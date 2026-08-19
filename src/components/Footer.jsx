import { useTranslation } from 'react-i18next'
import './footer.css'

export default function Footer() {
  const { t } = useTranslation()
  const l = t('footer.links', { returnObjects: true })
  return (
    <footer className="ftr">
      <div className="container ftr-grid">
        <div className="ftr-brand">
          <img src="/logos/aldea-blanco.svg" alt="Aldea" />
          <p>{t('footer.tagline')}</p>
        </div>
        <nav className="ftr-links">
          <h4>{t('footer.nav')}</h4>
          <a href="/">{l.home}</a>
          <a href="/acerca-de-aldea">{l.about}</a>
          <a href="/ubicaciones">{l.locations}</a>
          <a href="/lo-que-ofrecemos">{l.solutions}</a>
          <a href="/blog">{l.blog}</a>
        </nav>
        <nav className="ftr-links">
          <h4>Legal</h4>
          <a href="/terminos-y-condiciones">{l.terms}</a>
          <a href="/politicas-de-privacidad">{l.privacy}</a>
          <a href="/preguntas-frecuentes">{l.faq}</a>
        </nav>
        <div className="ftr-social">
          <h4>{t('footer.social')}</h4>
          <div className="ftr-icons">
            <a href="https://www.facebook.com/AldeaNetworking/" aria-label="Facebook" target="_blank" rel="noopener">Facebook</a>
            <a href="https://www.instagram.com/aldeanetworking/" aria-label="Instagram" target="_blank" rel="noopener">Instagram</a>
            <a href="https://www.tiktok.com/@aldea.networking" aria-label="TikTok" target="_blank" rel="noopener">TikTok</a>
          </div>
        </div>
      </div>
      <div className="ftr-bottom container">
        <span>© {new Date().getFullYear()} Aldea Networking. {t('footer.rights')}</span>
      </div>
    </footer>
  )
}
