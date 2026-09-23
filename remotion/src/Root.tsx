import "./index.css";
import React from "react";
import { Composition, Folder } from "remotion";
import { UnaRenta, Props } from "./UnaRenta";

// Cuatro versiones del mismo diagrama: espanol e ingles, horizontal (escritorio)
// y vertical 4:5 (movil). El sitio elige la que corresponde.
const VERSIONES: { id: string; props: Props; width: number; height: number }[] = [
  { id: "una-renta-es-16x9", props: { lang: "es", formato: "16x9" }, width: 1920, height: 1080 },
  { id: "una-renta-es-4x5", props: { lang: "es", formato: "4x5" }, width: 1080, height: 1350 },
  { id: "una-renta-en-16x9", props: { lang: "en", formato: "16x9" }, width: 1920, height: 1080 },
  { id: "una-renta-en-4x5", props: { lang: "en", formato: "4x5" }, width: 1080, height: 1350 },
];

export const RemotionRoot: React.FC = () => {
  return (
    <Folder name="Oficinas-Corporativas">
      {VERSIONES.map((v) => (
        <Composition
          key={v.id}
          id={v.id}
          component={UnaRenta}
          durationInFrames={420}
          fps={30}
          width={v.width}
          height={v.height}
          defaultProps={v.props}
        />
      ))}
    </Folder>
  );
};
