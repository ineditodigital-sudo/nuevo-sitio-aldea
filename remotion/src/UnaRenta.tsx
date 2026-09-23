// "Todo el proyecto integrado en una sola renta" (Oficinas Corporativas).
// 1) Las cinco partes por separado, cada una con su pago.
// 2) La tarjeta de Aldea se forma alrededor de ellas y las acomoda en lista.
// 3) Los cinco pagos se funden en uno.
// 4) La tarjeta se hace a un lado y queda el resultado: una sola renta mensual.
// El video empieza en el paso 4 (el resultado) y da la vuelta: 4, 1, 2, 3, 4.
import React from "react";
import { AbsoluteFill, Easing, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { loadFont } from "@remotion/google-fonts/Jost";
import { Icon } from "./iconos";
import { Idioma, PIEZAS, TXT } from "./textos";

const { fontFamily: JOST } = loadFont("normal", { weights: ["400", "500", "600"], subsets: ["latin", "latin-ext"] });

export type Formato = "16x9" | "4x5";
export type Props = { lang: Idioma; formato: Formato };

// Paleta del sitio (s6.css)
const C = {
  fondo: "#182943", // navy-800: panel sobre la seccion navy-900

  pieza: "rgba(255,255,255,0.06)",
  piezaLinea: "rgba(255,255,255,0.14)",
  fila: "rgba(255,255,255,0.14)",
  filaLinea: "rgba(255,255,255,0.24)",
  blanco: "#ffffff",
  suave: "#aebbcf",
  acento: "#2563eb",
  acentoClaro: "#8fb6ff",
  navy: "#0f1c30",
};

type Caja = { x: number; y: number; w: number; h: number };
type Punto = { x: number; y: number };

// Posiciones de cada momento para cada formato
function medidas(f: Formato) {
  if (f === "16x9") {
    const W = 1920, H = 1080;
    const cw = 312, ch = 260, gap = 40, total = 5 * cw + 4 * gap, x0 = (W - total) / 2, y0 = 470;
    const piezas: Caja[] = PIEZAS.map((_, i) => ({ x: x0 + i * (cw + gap), y: y0, w: cw, h: ch }));
    const mas: Punto[] = [0, 1, 2, 3].map((i) => ({ x: x0 + (i + 1) * cw + i * gap + gap / 2, y: y0 + ch / 2 }));
    const pagos: Caja[] = piezas.map((p) => ({ x: p.x, y: p.y + ch + 28, w: p.w, h: 60 }));
    // Tarjeta final a la derecha; mientras se forma, va centrada (desplazada "corrimiento")
    const pad = 48, cab = 56, fh = 90, fg = 14, bw = 1040, bx = W - 100 - bw;
    const bh = pad + cab + 26 + 5 * fh + 4 * fg + pad, by = (H - bh) / 2;
    const filas: Caja[] = PIEZAS.map((_, i) => ({ x: bx + pad, y: by + pad + cab + 26 + i * (fh + fg), w: bw - 2 * pad, h: fh }));
    // Bloque izquierdo final (titulo, subtitulo y renta) centrado a la altura de la tarjeta
    const bloque = 305, cy = by + (bh - bloque) / 2;
    const unPago: Caja = { x: x0, y: cy + bloque - 96, w: 560, h: 96 };
    return {
      W, H, piezas, mas, pagos, filas, unPago,
      tarjeta: { x: bx, y: by, w: bw, h: bh } as Caja,
      corrimiento: (W - bw) / 2 - bx, // de centrada a la derecha
      juntaPagos: { x: W / 2, y: by + bh + 58 } as Punto,
      icoRenta: { x: x0 + 48, y: unPago.y + 48 } as Punto,
      cap: { x: x0, y: 108 } as Punto, cap2: { x: x0, y: cy } as Punto, cap2Max: 560,
      capFs: 60, subFs: 34, piezaFs: 36, filaFs: 36, pagoFs: 28, rentaFs: 38,
      icoPieza: 72, icoFila: 40, logoH: 40, vertical: false,
    };
  }
  const W = 1080, H = 1350;
  const cw = 880, ch = 136, gap = 40, x0 = (W - cw) / 2, y0 = 335;
  const piezas: Caja[] = PIEZAS.map((_, i) => ({ x: x0, y: y0 + i * (ch + gap), w: cw, h: ch }));
  const mas: Punto[] = [0, 1, 2, 3].map((i) => ({ x: W / 2, y: y0 + (i + 1) * ch + i * gap + gap / 2 }));
  const pagos: Caja[] = piezas.map((p) => ({ x: p.x + p.w - 78, y: p.y + (ch - 56) / 2, w: 56, h: 56 }));
  const bw = 920, bx = (W - bw) / 2, by = 305, pad = 44, cab = 56, fh = 106, fg = 14;
  const filas: Caja[] = PIEZAS.map((_, i) => ({ x: bx + pad, y: by + pad + cab + 26 + i * (fh + fg), w: bw - 2 * pad, h: fh }));
  const bh = pad + cab + 26 + 5 * fh + 4 * fg + pad;
  const unPago: Caja = { x: W / 2 - 400, y: by + bh + 40, w: 800, h: 104 };
  return {
    W, H, piezas, mas, pagos, filas, unPago,
    tarjeta: { x: bx, y: by, w: bw, h: bh } as Caja,
    corrimiento: 0,
    juntaPagos: { x: W / 2 - 330, y: unPago.y + unPago.h / 2 } as Punto,
    icoRenta: { x: W / 2 - 330, y: unPago.y + unPago.h / 2 } as Punto,
    cap: { x: x0, y: 92 } as Punto, cap2: { x: x0, y: 92 } as Punto, cap2Max: 900,
    capFs: 72, subFs: 38, piezaFs: 44, filaFs: 44, pagoFs: 0, rentaFs: 50,
    icoPieza: 72, icoFila: 48, logoH: 44, vertical: true,
  };
}

// Tiempos de la historia (30 fps). Duracion total: 420 cuadros = 14 s, en bucle.
const DURACION = 420;
// El video arranca con el resultado ya armado, que es tambien el poster: quien llega
// a la seccion ve primero la respuesta y despues como se llega a ella. Sin salto al empezar.
export const INICIO = 300;
const T = {
  titulo: [0, 16] as [number, number],
  pieza: (i: number) => 10 + i * 6,
  mas: (i: number) => 18 + i * 6,
  pago: (i: number) => 40 + i * 5,
  soltar: [140, 156] as [number, number], // se van los + y el texto de los pagos
  tarjeta: [146, 174] as [number, number], // la tarjeta se forma alrededor de las piezas
  acomodar: (i: number): [number, number] => [150 + i * 4, 192 + i * 4], // piezas a filas
  juntar: [158, 200] as [number, number], // los cinco recibos se juntan
  logo: [190, 212] as [number, number],
  correr: [202, 236] as [number, number], // la tarjeta se va a la derecha
  cambio: [200, 232] as [number, number], // "Por separado" -> "Con Aldea"
  renta: [218, 242] as [number, number],
  palomita: (i: number) => 232 + i * 5,
  salida: [398, 416] as [number, number],
};

const clamp = { extrapolateLeft: "clamp", extrapolateRight: "clamp" } as const;
const MOVER = Easing.bezier(0.65, 0, 0.35, 1); // movimiento en pantalla
const LLEGAR = Easing.bezier(0.16, 1, 0.3, 1); // entradas
const SALIR = Easing.bezier(0.4, 0, 1, 1);
const lerp = (a: number, b: number, t: number) => a + (b - a) * t;
const tramo = (frame: number, r: [number, number], e = MOVER) => interpolate(frame, r, [0, 1], { ...clamp, easing: e });

export const UnaRenta: React.FC<Props> = ({ lang, formato }) => {
  const frame = (useCurrentFrame() + INICIO) % DURACION;
  const { fps } = useVideoConfig();
  const M = medidas(formato);
  const t = TXT[lang];

  const salida = interpolate(frame, T.salida, [1, 0], { ...clamp, easing: SALIR });
  const titulo = tramo(frame, T.titulo, LLEGAR);
  const soltar = tramo(frame, T.soltar, LLEGAR);
  const tarjeta = tramo(frame, T.tarjeta, LLEGAR);
  const juntar = tramo(frame, T.juntar);
  const logo = tramo(frame, T.logo, LLEGAR);
  const correr = tramo(frame, T.correr);
  const cambio = tramo(frame, T.cambio);
  const renta = tramo(frame, T.renta, LLEGAR);
  const dx = lerp(M.corrimiento, 0, correr); // desplazamiento de tarjeta y filas

  const texto = (tit: string, sub: string, o: number, dy: number, pos: Punto, max?: number) => (
    <div style={{ position: "absolute", left: pos.x, top: pos.y, opacity: o, translate: `0px ${dy}px`, maxWidth: max }}>
      <div style={{ fontWeight: 600, fontSize: M.capFs, lineHeight: 1.05, color: C.blanco, letterSpacing: "-0.02em" }}>{tit}</div>
      <div style={{ fontWeight: 400, fontSize: M.subFs, lineHeight: 1.3, color: C.suave, marginTop: 14 }}>{sub}</div>
    </div>
  );

  return (
    <AbsoluteFill style={{ backgroundColor: C.fondo, fontFamily: JOST }}>
      <AbsoluteFill style={{ opacity: salida }}>
        {/* Titulo: "Por separado" y luego "Con Aldea" */}
        {/* En horizontal la tarjeta se forma encima del primer titulo: se va antes */}
        {texto(t.antes, t.antesSub, titulo * (1 - (M.vertical ? cambio : soltar)), -16 * (M.vertical ? cambio : soltar), M.cap)}
        {texto(t.despues, t.despuesSub, cambio, 16 * (1 - cambio), M.cap2, M.cap2Max)}

        {/* Tarjeta de Aldea: se forma alrededor de las piezas */}
        <div
          style={{
            position: "absolute", left: M.tarjeta.x + dx, top: M.tarjeta.y, width: M.tarjeta.w, height: M.tarjeta.h,
            borderRadius: 28, backgroundColor: C.acento, opacity: tarjeta,
            scale: interpolate(tarjeta, [0, 1], [0.9, 1]),
            boxShadow: `0 ${30 * tarjeta}px 60px rgba(0,0,0,0.28)`,
          }}
        >
          <Img src={staticFile("logo-blanco.svg")} style={{ position: "absolute", left: M.filas[0].x - M.tarjeta.x, top: M.vertical ? 42 : 48, height: M.logoH, opacity: logo }} />
        </div>

        {/* Signos + entre las piezas */}
        {M.mas.map((m, i) => {
          const s = spring({ frame: frame - T.mas(i), fps, config: { damping: 200 } });
          return (
            <div key={i} style={{ position: "absolute", left: m.x - 22, top: m.y - 22, width: 44, height: 44, display: "flex", alignItems: "center", justifyContent: "center", color: C.acentoClaro, fontSize: 44, lineHeight: 1, opacity: s * (1 - soltar) }}>+</div>
          );
        })}

        {/* Las cinco piezas: de tarjetas sueltas a filas dentro de la tarjeta de Aldea */}
        {PIEZAS.map((p, i) => {
          const a = M.piezas[i], b = M.filas[i];
          const entra = spring({ frame: frame - T.pieza(i), fps, config: { damping: 200 } });
          const m = tramo(frame, T.acomodar(i));
          const x = lerp(a.x, b.x + M.corrimiento, m) + (dx - M.corrimiento) * (m >= 1 ? 1 : m);
          const y = lerp(a.y, b.y, m), w = lerp(a.w, b.w, m), h = lerp(a.h, b.h, m);
          const verPieza = interpolate(m, [0, 0.4], [1, 0], clamp);
          const verFila = interpolate(m, [0.5, 1], [0, 1], clamp);
          const palomita = spring({ frame: frame - T.palomita(i), fps, config: { damping: 200 } });
          const etiqueta = p[lang];
          return (
            <div
              key={p.es}
              style={{
                position: "absolute", left: x, top: y, width: w, height: h,
                borderRadius: lerp(20, 16, m),
                backgroundColor: m < 0.5 ? C.pieza : C.fila,
                border: `1.5px solid ${m < 0.5 ? C.piezaLinea : C.filaLinea}`,
                opacity: entra, translate: `0px ${(1 - entra) * 28}px`, overflow: "hidden",
              }}
            >
              <div style={{ position: "absolute", inset: 0, opacity: verPieza, display: "flex", flexDirection: M.vertical ? "row" : "column", alignItems: M.vertical ? "center" : "flex-start", gap: M.vertical ? 26 : 22, padding: M.vertical ? "0 30px" : 26 }}>
                <div style={{ width: M.icoPieza, height: M.icoPieza, borderRadius: "50%", backgroundColor: "rgba(255,255,255,0.08)", display: "flex", alignItems: "center", justifyContent: "center", flex: "none" }}>
                  <Icon name={p.icono} size={M.icoPieza * 0.5} color="#cfe0ff" />
                </div>
                <div style={{ fontSize: M.piezaFs, fontWeight: 500, lineHeight: 1.18, color: C.blanco, maxWidth: M.vertical ? 620 : undefined }}>{etiqueta}</div>
              </div>
              <div style={{ position: "absolute", inset: 0, opacity: verFila, display: "flex", alignItems: "center", gap: 24, padding: "0 26px" }}>
                <Icon name={p.icono} size={M.icoFila} color={C.blanco} />
                <div style={{ flex: 1, fontSize: M.filaFs, fontWeight: 500, color: C.blanco, whiteSpace: "nowrap" }}>{etiqueta}</div>
                <div style={{ width: M.icoFila + 12, height: M.icoFila + 12, borderRadius: "50%", backgroundColor: C.blanco, display: "flex", alignItems: "center", justifyContent: "center", opacity: palomita, scale: interpolate(palomita, [0, 1], [0.6, 1]) }}>
                  <Icon name="check" size={M.icoFila * 0.7} color={C.acento} stroke={2.4} />
                </div>
              </div>
            </div>
          );
        })}

        {/* Pagos: cada parte con su recibo; se funden en uno solo */}
        {M.pagos.map((c, i) => {
          const s = spring({ frame: frame - T.pago(i), fps, config: { damping: 200 } });
          const icoX0 = M.vertical ? c.x + c.w / 2 : c.x + c.w / 2 - 34;
          const icoY0 = c.y + c.h / 2;
          // primero se juntan en un punto; el recibo que queda viaja a la renta
          const jx = lerp(icoX0, M.juntaPagos.x, juntar), jy = lerp(icoY0, M.juntaPagos.y, juntar);
          const fx = lerp(jx, M.icoRenta.x, correr), fy = lerp(jy, M.icoRenta.y, correr);
          const visible = i === 0 ? 1 : interpolate(juntar, [0.75, 1], [1, 0], clamp);
          const ocultar = interpolate(renta, [0.6, 1], [1, 0], clamp); // lo releva el icono de la renta
          return (
            <React.Fragment key={i}>
              {M.vertical ? null : (
                <div style={{ position: "absolute", left: c.x, top: c.y, width: c.w, height: c.h, opacity: s * (1 - soltar), display: "flex", alignItems: "center", justifyContent: "center", borderRadius: 999, border: `1.5px dashed ${C.piezaLinea}`, color: C.suave, fontSize: M.pagoFs, fontWeight: 500 }}>
                  <span style={{ marginLeft: 44 }}>{t.pago}</span>
                </div>
              )}
              <div style={{ position: "absolute", left: fx - 20, top: fy - 20, width: 40, height: 40, display: "flex", alignItems: "center", justifyContent: "center", opacity: s * visible * ocultar }}>
                <Icon name="recibo" size={M.vertical ? 34 : 30} color={C.acentoClaro} />
              </div>
            </React.Fragment>
          );
        })}

        {/* Resultado: una sola renta mensual */}
        <div
          style={{
            position: "absolute", left: M.unPago.x, top: M.unPago.y, width: M.unPago.w, height: M.unPago.h,
            borderRadius: 999, backgroundColor: C.blanco, color: C.navy, opacity: renta,
            scale: interpolate(renta, [0, 1], [0.94, 1]),
            display: "flex", alignItems: "center", justifyContent: M.vertical ? "center" : "flex-start",
            gap: 18, paddingLeft: M.vertical ? 0 : 30,
            fontSize: M.rentaFs, fontWeight: 600, letterSpacing: "-0.01em",
            boxShadow: "0 18px 40px rgba(0,0,0,0.25)",
          }}
        >
          <Icon name="recibo" size={M.rentaFs * 1.05} color={C.acento} stroke={2} />
          <span>{t.resultado}</span>
        </div>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
