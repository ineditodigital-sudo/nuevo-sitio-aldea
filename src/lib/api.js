// Cliente de la API de Aldea.
// La URL base se define en .env (VITE_API_URL). Si está vacía,
// el frontend usa el contenido local de /src/i18n como fallback.
export const API_URL = import.meta.env.VITE_API_URL || ''
export const hasApi = API_URL !== ''

async function get(path, lang) {
  const sep = path.includes('?') ? '&' : '?'
  const res = await fetch(`${API_URL}${path}${sep}lang=${lang}`, {
    headers: { Accept: 'application/json' },
  })
  if (!res.ok) throw new Error(`API ${res.status}`)
  return res.json()
}

export const api = {
  home: (lang) => get('/api/home', lang),
  solutions: (lang) => get('/api/solutions', lang),
  locations: (lang) => get('/api/locations', lang),
  location: (slug, lang) => get(`/api/locations/${slug}`, lang),
  posts: (lang) => get('/api/posts', lang),
  post: (slug, lang) => get(`/api/posts/${slug}`, lang),
  page: (slug, lang) => get(`/api/pages/${slug}`, lang),
  createLead: (data) =>
    fetch(`${API_URL}/api/leads`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    }).then((r) => r.json()),
}
