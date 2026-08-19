import { useEffect, useState } from 'react'
import { useTranslation } from 'react-i18next'
import { api, hasApi } from '../lib/api'

/**
 * Devuelve el contenido dinámico de la Home.
 * - Si hay API configurada (VITE_API_URL), lo trae desde MySQL.
 * - Si no, arma un fallback con el contenido local de i18n,
 *   para que el sitio funcione en desarrollo sin backend.
 */
export function useHomeData() {
  const { t, i18n } = useTranslation()
  const lang = i18n.language

  const fallback = () => ({
    content: {
      'hero.title': t('hero.title'),
      'hero.subtitle': t('hero.subtitle'),
      'solutions.title': t('solutions.title'),
      'solutions.subtitle': t('solutions.subtitle'),
      'clients.title': t('clients.title'),
      'clients.subtitle': t('clients.subtitle'),
      'locations.title': t('locations.title'),
      'locations.subtitle': t('locations.subtitle'),
      'testimonials.title': t('testimonials.title'),
      'contact.title': t('contact.title'),
      'contact.subtitle': t('contact.subtitle'),
      'contact.phone': t('contact.phone'),
    },
    solutions: t('solutions.items', { returnObjects: true }).map((s) => ({
      title: s.title, excerpt: s.text, slug: s.href.split('/').pop(),
    })),
    clients: t('clients.logos', { returnObjects: true }).map((name) => ({ name, logo: null })),
    locations: t('locations.items', { returnObjects: true }).map((l) => ({
      name: l.name, city: l.city, address: l.address, image: l.img, slug: l.href.split('/').pop(),
    })),
    testimonials: t('testimonials.items', { returnObjects: true }).map((tm) => ({
      name: tm.name, company: tm.company, quote: tm.quote,
    })),
  })

  const [data, setData] = useState(fallback)

  useEffect(() => {
    let alive = true
    if (!hasApi) { setData(fallback()); return }
    api.home(lang)
      .then((d) => { if (alive) setData(d) })
      .catch(() => { if (alive) setData(fallback()) })
    return () => { alive = false }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [lang])

  return data
}
