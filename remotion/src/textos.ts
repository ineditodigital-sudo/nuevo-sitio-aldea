// Textos del diagrama. Son los mismos del panel (Oficinas Corporativas, seccion "renta").
// Si cambian alla, hay que actualizarlos aqui y volver a renderizar (ver README).
import type { Icono } from "./iconos";

export type Idioma = "es" | "en";

export const PIEZAS: { icono: Icono; es: string; en: string }[] = [
  { icono: "inmueble", es: "Uso del inmueble", en: "Use of the property" },
  { icono: "obra", es: "Proyecto y adecuaciones", en: "Design and fit-out" },
  { icono: "mobiliario", es: "Mobiliario", en: "Furniture" },
  { icono: "red", es: "Infraestructura y tecnología", en: "Infrastructure and technology" },
  { icono: "servicios", es: "Servicios y operación", en: "Services and operation" },
];

export const TXT = {
  es: {
    antes: "Por separado",
    antesSub: "Un proveedor, un contrato y un pago para cada parte",
    pago: "Pago",
    despues: "Con Aldea",
    despuesSub: "Un solo contrato para todo el proyecto",
    resultado: "Una sola renta mensual",
  },
  en: {
    antes: "Separately",
    antesSub: "A supplier, a contract and a payment for each part",
    pago: "Payment",
    despues: "With Aldea",
    despuesSub: "One contract for the whole project",
    resultado: "One monthly rent",
  },
} as const;
