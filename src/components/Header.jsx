import { useState, useEffect } from 'react'
import { useTranslation } from 'react-i18next'
import './header.css'

export default function Header() {
  const { t, i18n } = useTranslation()
  const [scrolled, setScrolled] = useState(false)
  const [open, setOpen] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 20)
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  const toggleLang = (lng) => {
    i18n.changeLanguage(lng)
    localStorage.setItem('aldea_lang', lng)
  }

  const solutions = t('nav.solutions', { returnObjects: true })
  const locs = t('nav.locationsList', { returnObjects: true })

  return (
    <header className={`hdr ${scrolled ? 'is-scrolled' : ''}`}>
      <div className="hdr-inner container">
        <a href="/" className="hdr-logo" aria-label="Aldea">
          <img src="/logos/aldea-azul.svg" alt="Aldea" />
        </a>

        <nav className={`hdr-nav ${open ? 'open' : ''}`}>
          <a href="/acerca-de-aldea">{t('nav.about')}</a>

          <div className="hdr-drop">
            <button>{t('nav.offer')} <Chevron /></button>
            <div className="hdr-menu">
              <a href="/soluciones/oficina-privada">{solutions.private}</a>
              <a href="/soluciones/coworking">{solutions.coworking}</a>
              <a href="/soluciones/domicilio-virtual">{solutions.virtual}</a>
              <a href="/soluciones/escritorio-privado">{solutions.desk}</a>
              <a href="/soluciones/oficinas-personalizadas">{solutions.custom}</a>
              <a href="/lo-que-ofrecemos" className="menu-all">{solutions.all}</a>
            </div>
          </div>

          <div className="hdr-drop">
            <button>{t('nav.locations')} <Chevron /></button>
            <div className="hdr-menu">
              <a href="/ubicaciones/aguascalientes">{locs.ags}</a>
              <a href="/ubicaciones/leon-guanajuato">{locs.leon}</a>
              <a href="/ubicaciones/san-luis-potosi">{locs.slp}</a>
              <a href="/ubicaciones/queretaro">{locs.qro}</a>
              <a href="/ubicaciones" className="menu-all">{locs.all}</a>
            </div>
          </div>

          <a href="/blog">{t('nav.blog')}</a>
        </nav>

        <div className="hdr-actions">
          <div className="hdr-lang" role="group" aria-label="Idioma">
            <button className={i18n.language === 'es' ? 'on' : ''} onClick={() => toggleLang('es')}>ES</button>
            <span>/</span>
            <button className={i18n.language === 'en' ? 'on' : ''} onClick={() => toggleLang('en')}>EN</button>
          </div>
          <a href="/contacto" className="btn btn-primary hdr-cta">{t('nav.cta')}</a>
          <button className="hdr-burger" aria-label="Menú" onClick={() => setOpen(!open)}>
            <span /><span /><span />
          </button>
        </div>
      </div>
    </header>
  )
}

function Chevron() {
  return (
    <svg width="10" height="10" viewBox="0 0 10 6" fill="none" aria-hidden="true">
      <path d="M1 1l4 4 4-4" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  )
}
