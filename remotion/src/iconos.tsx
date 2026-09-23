// Trazos de Tabler Icons (MIT): los mismos que usa el sitio (cms/icons.php).
import React from "react";

const P: Record<string, string[]> = {
  inmueble: ["M3 21l18 0", "M5 21v-14l8 -4v18", "M19 21v-10l-6 -4", "M9 9l0 .01", "M9 12l0 .01", "M9 15l0 .01", "M9 18l0 .01"],
  obra: ["M3 21h4l13 -13a1.5 1.5 0 0 0 -4 -4l-13 13v4", "M14.5 5.5l4 4", "M12 8l-5 -5l-4 4l5 5", "M7 8l-1.5 1.5", "M16 12l5 5l-4 4l-5 -5", "M16 17l-1.5 1.5"],
  mobiliario: ["M5 11a2 2 0 0 1 2 2v2h10v-2a2 2 0 1 1 4 0v4a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-4a2 2 0 0 1 2 -2", "M5 11v-5a3 3 0 0 1 3 -3h8a3 3 0 0 1 3 3v5", "M6 19v2", "M18 19v2"],
  red: ["M6 9a6 6 0 1 0 12 0a6 6 0 0 0 -12 0", "M12 3c1.333 .333 2 2.333 2 6s-.667 5.667 -2 6", "M12 3c-1.333 .333 -2 2.333 -2 6s.667 5.667 2 6", "M6 9h12", "M3 20h7", "M14 20h7", "M10 20a2 2 0 1 0 4 0a2 2 0 0 0 -4 0", "M12 15v3"],
  servicios: ["M4 14v-3a8 8 0 1 1 16 0v3", "M18 19c0 1.657 -2.686 3 -6 3", "M4 14a2 2 0 0 1 2 -2h1a2 2 0 0 1 2 2v3a2 2 0 0 1 -2 2h-1a2 2 0 0 1 -2 -2v-3", "M15 14a2 2 0 0 1 2 -2h1a2 2 0 0 1 2 2v3a2 2 0 0 1 -2 2h-1a2 2 0 0 1 -2 -2v-3"],
  recibo: ["M5 21v-16a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v16l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2m4 -14h6m-6 4h6m-2 4h2"],
  check: ["M5 12l5 5l10 -10"],
};

export type Icono = keyof typeof P;

export const Icon: React.FC<{ name: Icono; size: number; color: string; stroke?: number }> = ({ name, size, color, stroke = 1.75 }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={stroke} strokeLinecap="round" strokeLinejoin="round">
    {P[name].map((d) => (
      <path key={d} d={d} />
    ))}
  </svg>
);
