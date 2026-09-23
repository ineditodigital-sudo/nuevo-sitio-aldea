# Video "Una sola renta" (Oficinas Corporativas)

Animación del diagrama de Oficinas Corporativas. Se hace con [Remotion](https://www.remotion.dev/) y se exporta a MP4 para el sitio. La página no carga nada de React.

## Composiciones

| ID | Tamaño | Uso |
| --- | --- | --- |
| `una-renta-es-16x9` | 1920 × 1080 | Escritorio, español |
| `una-renta-es-4x5` | 1080 × 1350 | Móvil (≤ 700 px), español |
| `una-renta-en-16x9` | 1920 × 1080 | Escritorio, inglés |
| `una-renta-en-4x5` | 1080 × 1350 | Móvil (≤ 700 px), inglés |

Las cuatro duran 14 s (420 cuadros a 30 fps) y están hechas para repetirse en bucle.

- `src/UnaRenta.tsx`: la animación.
- `src/textos.ts`: los textos en ES y EN.
- `src/iconos.tsx`: los íconos, trazos de Tabler Icons (los mismos del sitio).

## Editar

```bash
npm i
npm run dev
```

## Exportar para el sitio

1. Render y póster. El video arranca con el resultado ya armado (constante `INICIO` en `src/UnaRenta.tsx`), así que el póster es el cuadro 0 y no hay salto cuando empieza a reproducirse:

   ```bash
   for id in una-renta-es-16x9 una-renta-es-4x5 una-renta-en-16x9 una-renta-en-4x5; do npx remotion render $id "out/$id.mp4" --codec=h264 --crf=20 --pixel-format=yuv420p --muted; npx remotion still $id "out/$id.png" --frame=0; done
   ```

2. Desde la raíz del repo, recomprimir para web y convertir los pósters a WebP (requiere ffmpeg e ImageMagick):

   ```bash
   for n in una-renta-es-16x9 una-renta-es-4x5 una-renta-en-16x9 una-renta-en-4x5; do ffmpeg -y -i "remotion/out/$n.mp4" -c:v libx264 -preset slow -crf 21 -pix_fmt yuv420p -color_range tv -movflags +faststart -an "sitio-produccion/video/una-renta/$n.mp4" && magick "remotion/out/$n.png" -quality 82 "sitio-produccion/video/una-renta/$n.webp"; done
   ```

`cms/tpl_corporativas.php` busca esos ocho archivos. Si faltan, muestra el diagrama en HTML como antes.

## Licencia

Remotion es gratis para personas, organizaciones sin fines de lucro y empresas de hasta 3 personas. Una empresa más grande necesita la licencia de empresa: https://www.remotion.dev/license
