import { useEffect, useState } from 'react'
import { useTranslation } from 'react-i18next'
import { useHomeData } from '../hooks/useHomeData'
import { api, hasApi } from '../lib/api'
import './home.css'

function useReveal(dep) {
  useEffect(() => {
    const els = document.querySelectorAll('.reveal:not(.is-visible)')
    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => { if (e.isIntersecting) { e.target.classList.add('is-visible'); io.unobserve(e.target) } })
    }, { threshold: 0.14 })
    els.forEach((el) => io.observe(el))
    return () => io.disconnect()
  }, [dep])
}

export default function Home() {
  const { t } = useTranslation()
  const data = useHomeData()
  useReveal(data)
  const c = data.content
  const features = t('features.items', { returnObjects: true })

  return (
    <>
      <section className="hero">
        <div className="hero-media">
          <img src="/img/hero.webp" alt="" />
          <div className="hero-overlay" />
        </div>
        <div className="container hero-inner">
          <div className="hero-copy reveal">
            <span className="eyebrow hero-eyebrow">Aldea Networking</span>
            <h1>{c['hero.title']}</h1>
            <p className="lead">{c['hero.subtitle']}</p>
            <div className="hero-cta">
              <a href="#contacto" className="btn btn-accent">{t('hero.cta')}</a>
              <a href="/ubicaciones" className="btn btn-white">{t('hero.cta2')}</a>
            </div>
          </div>
        </div>
        <div className="hero-scroll" aria-hidden="true"><span /></div>
      </section>

      <section className="section" id="soluciones">
        <div className="container">
          <div className="sec-head reveal">
            <span className="eyebrow">{t('solutions.eyebrow')}</span>
            <h2>{c['solutions.title']}</h2>
            <p className="lead">{c['solutions.subtitle']}</p>
          </div>
          <div className="sol-grid">
            {data.solutions.slice(0, 3).map((s, i) => (
              <a key={i} href={`/soluciones/${s.slug}`} className="sol-card reveal" style={{ transitionDelay: `${i * 90}ms` }}>
                <span className="sol-num">0{i + 1}</span>
                <h3>{s.title}</h3>
                <p>{s.excerpt}</p>
                <span className="link-arrow">{t('solutions.more')} <Arrow /></span>
              </a>
            ))}
          </div>
          <div className="sec-foot reveal">
            <a href="/lo-que-ofrecemos" className="btn btn-ghost">{t('solutions.seeAll')}</a>
          </div>
        </div>
      </section>

      <section className="clients section">
        <div className="container">
          <div className="sec-head reveal">
            <h2>{c['clients.title']}</h2>
            <p className="lead">{c['clients.subtitle']}</p>
          </div>
          <div className="clients-marquee reveal">
            <div className="clients-track">
              {[...data.clients, ...data.clients].map((cl, i) => (
                <span key={i} className="client-chip">
                  {cl.logo ? <img src={cl.logo} alt={cl.name} /> : cl.name}
                </span>
              ))}
            </div>
          </div>
        </div>
      </section>

      <section className="section features">
        <div className="container feat-grid">
          {features.map((f, i) => (
            <article key={i} className={`feat-card reveal ${i === 0 ? 'feat-big' : ''}`} style={{ transitionDelay: `${i * 90}ms` }}>
              <div className="feat-img"><img src={f.img} alt={f.title} loading="lazy" /></div>
              <div className="feat-body">
                <h3>{f.title}</h3>
                <p>{f.text}</p>
              </div>
            </article>
          ))}
        </div>
      </section>

      <section className="section locs" id="ubicaciones">
        <div className="container">
          <div className="sec-head reveal">
            <span className="eyebrow">{t('locations.eyebrow')}</span>
            <h2>{c['locations.title']}</h2>
            <p className="lead">{c['locations.subtitle']}</p>
          </div>
          <div className="locs-grid">
            {data.locations.map((l, i) => (
              <a key={i} href={`/ubicaciones/${l.slug}`} className="loc-card reveal" style={{ transitionDelay: `${i * 80}ms` }}>
                <div className="loc-img"><img src={l.image} alt={l.name} loading="lazy" /></div>
                <div className="loc-body">
                  <span className="loc-city">{l.city}</span>
                  <h3>{l.name}</h3>
                  <p>{l.address}</p>
                  <span className="link-arrow">{t('locations.more')} <Arrow /></span>
                </div>
              </a>
            ))}
          </div>
          <div className="sec-foot reveal">
            <a href="/ubicaciones" className="btn btn-ghost">{t('locations.all')}</a>
          </div>
        </div>
      </section>

      <section className="section testi">
        <div className="container">
          <div className="sec-head reveal"><h2>{c['testimonials.title']}</h2></div>
          <div className="testi-grid">
            {data.testimonials.map((tm, i) => (
              <figure key={i} className="testi-card reveal" style={{ transitionDelay: `${i * 70}ms` }}>
                <Quote />
                <blockquote>{tm.quote}</blockquote>
                <figcaption>
                  <strong>{tm.name}</strong>
                  <span>{tm.company}</span>
                </figcaption>
              </figure>
            ))}
          </div>
        </div>
      </section>

      <ContactSection content={c} />
    </>
  )
}

function ContactSection({ content }) {
  const { t } = useTranslation()
  const [status, setStatus] = useState('idle')
  const phone = content['contact.phone'] || ''

  const onSubmit = async (e) => {
    e.preventDefault()
    const payload = Object.fromEntries(new FormData(e.target).entries())
    payload.source = 'home'
    setStatus('sending')
    try {
      if (hasApi) await api.createLead(payload)
      setStatus('ok')
      e.target.reset()
    } catch {
      setStatus('error')
    }
  }

  return (
    <section className="contact section" id="contacto">
      <div className="container contact-inner">
        <div className="contact-copy reveal">
          <h2>{content['contact.title']}</h2>
          <p className="lead">{content['contact.subtitle']}</p>
          <p className="contact-phone">
            {t('contact.phoneLabel')} <a href={`tel:${phone.replace(/\s/g, '')}`}>{phone}</a>
          </p>
        </div>
        <form className="contact-form reveal" onSubmit={onSubmit}>
          <input name="name" type="text" placeholder={t('contact.name')} required />
          <input name="email" type="email" placeholder={t('contact.email')} required />
          <input name="phone" type="tel" placeholder={t('contact.phoneField')} />
          <textarea name="message" rows="4" placeholder={t('contact.message')} />
          <button type="submit" className="btn btn-accent" disabled={status === 'sending'}>
            {status === 'sending' ? '…' : t('contact.send')}
          </button>
          {status === 'ok' && <small className="form-ok">✓ {t('contact.privacy')}</small>}
          {status === 'error' && <small className="form-err">Ocurrió un error. Inténtalo de nuevo.</small>}
          {status === 'idle' && <small>{t('contact.privacy')}</small>}
        </form>
      </div>
    </section>
  )
}

function Arrow() {
  return <svg width="16" height="12" viewBox="0 0 16 12" fill="none" aria-hidden="true"><path d="M1 6h13M9 1l5 5-5 5" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round" /></svg>
}
function Quote() {
  return <svg className="q-mark" width="34" height="26" viewBox="0 0 34 26" fill="none" aria-hidden="true"><path d="M0 26V15C0 6 5 1 14 0l1 4C9 5 6 8 6 13h6v13H0Zm19 0V15C19 6 24 1 33 0l1 4c-6 1-9 4-9 9h6v13H19Z" fill="currentColor"/></svg>
}
