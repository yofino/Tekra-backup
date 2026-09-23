import { useEffect, useRef } from 'react'
import { Link } from 'react-router-dom'
import { useTheme } from '../context/ThemeContext'

function NetworkCanvas() {
  const canvasRef = useRef(null)
  useEffect(() => {
    const canvas = canvasRef.current
    const ctx = canvas.getContext('2d')
    let animId
    const resize = () => { canvas.width = canvas.offsetWidth; canvas.height = canvas.offsetHeight }
    resize()
    window.addEventListener('resize', resize)
    const nodes = Array.from({ length: 40 }, () => ({
      x: Math.random() * canvas.width, y: Math.random() * canvas.height,
      vx: (Math.random() - 0.5) * 0.4, vy: (Math.random() - 0.5) * 0.4,
      r: Math.random() * 2 + 1,
    }))
    const packets = []
    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      for (let i = 0; i < nodes.length; i++) {
        for (let j = i + 1; j < nodes.length; j++) {
          const dx = nodes[i].x - nodes[j].x, dy = nodes[i].y - nodes[j].y
          const dist = Math.sqrt(dx * dx + dy * dy)
          if (dist < 160) {
            ctx.beginPath()
            ctx.strokeStyle = `rgba(44,56,142,${(1 - dist / 160) * 0.3})`
            ctx.lineWidth = 0.8
            ctx.moveTo(nodes[i].x, nodes[i].y)
            ctx.lineTo(nodes[j].x, nodes[j].y)
            ctx.stroke()
            if (Math.random() < 0.0003) packets.push({ from: i, to: j, t: 0, speed: 0.008 + Math.random() * 0.006 })
          }
        }
      }
      nodes.forEach(n => { ctx.beginPath(); ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2); ctx.fillStyle = 'rgba(74,95,212,0.7)'; ctx.fill() })
      for (let i = packets.length - 1; i >= 0; i--) {
        const p = packets[i]; p.t += p.speed
        if (p.t >= 1) { packets.splice(i, 1); continue }
        const a = nodes[p.from], b = nodes[p.to]
        ctx.beginPath(); ctx.arc(a.x + (b.x - a.x) * p.t, a.y + (b.y - a.y) * p.t, 2.5, 0, Math.PI * 2)
        ctx.fillStyle = 'rgba(255,103,0,0.85)'; ctx.fill()
      }
      nodes.forEach(n => {
        n.x += n.vx; n.y += n.vy
        if (n.x < 0 || n.x > canvas.width) n.vx *= -1
        if (n.y < 0 || n.y > canvas.height) n.vy *= -1
      })
      animId = requestAnimationFrame(draw)
    }
    draw()
    return () => { cancelAnimationFrame(animId); window.removeEventListener('resize', resize) }
  }, [])
  return <canvas ref={canvasRef} className="absolute inset-0 w-full h-full" />
}

function WaveDecor() {
  return (
    <div className="absolute bottom-0 left-0 right-0 pointer-events-none select-none" style={{ height: 120, overflow: 'hidden' }}>
      <div style={{ position: 'absolute', bottom: 0, left: 0, width: '200%', height: 120, animation: 'wave-slide 12s linear infinite' }}>
        <svg viewBox="0 0 2880 120" preserveAspectRatio="none" style={{ width: '100%', height: '100%' }}>
          <path d="M0,50 C240,95 480,8 720,50 C960,92 1200,8 1440,50 C1680,92 1920,8 2160,50 C2400,92 2640,8 2880,50 L2880,120 L0,120 Z" fill="#FF6700" fillOpacity="0.08" />
        </svg>
      </div>
      <div style={{ position: 'absolute', bottom: 0, left: 0, width: '200%', height: 90, animation: 'wave-slide 9s linear infinite reverse' }}>
        <svg viewBox="0 0 2880 90" preserveAspectRatio="none" style={{ width: '100%', height: '100%' }}>
          <path d="M0,35 C200,70 440,4 720,36 C1000,68 1240,4 1440,36 C1640,68 1880,4 2160,36 C2440,68 2680,4 2880,36 L2880,90 L0,90 Z" fill="#FF6700" fillOpacity="0.13" />
        </svg>
      </div>
      <div style={{ position: 'absolute', bottom: 0, left: 0, width: '200%', height: 60, animation: 'wave-slide 7s linear infinite' }}>
        <svg viewBox="0 0 2880 60" preserveAspectRatio="none" style={{ width: '100%', height: '100%' }}>
          <path d="M0,22 C180,50 420,2 720,24 C1020,46 1260,2 1440,24 C1620,46 1860,2 2160,24 C2460,46 2700,2 2880,24 L2880,60 L0,60 Z" fill="#FF6700" fillOpacity="0.20" />
        </svg>
      </div>
    </div>
  )
}

export default function Hero() {
  const { dark } = useTheme()
  const wrapperRef = useRef(null)
  const sectionRef = useRef(null)
  const contentRef = useRef(null)
  const lockRef = useRef(false)

  useEffect(() => {
    const section = sectionRef.current
    const content = contentRef.current
    if (!section || !content) return

    const SCROLL_RANGE = section.offsetHeight * 0.7
    const onScroll = () => {
      const progress = Math.min(Math.max(window.scrollY / SCROLL_RANGE, 0), 1)
      content.style.transform = `perspective(1000px) rotateX(${progress * 20}deg) scale(${1 - progress * 0.07}) translateZ(${-progress * 140}px)`
      content.style.opacity = Math.max(1 - progress * 1.6, 0)
      content.style.filter = `blur(${progress * 6}px)`
    }
    window.addEventListener('scroll', onScroll, { passive: true })

    const snapNext = () => {
      const next = wrapperRef.current?.nextElementSibling
      if (!next) return
      lockRef.current = true
      next.scrollIntoView({ behavior: 'smooth' })
      setTimeout(() => { lockRef.current = false }, 1000)
    }
    const snapTop = () => {
      lockRef.current = true
      window.scrollTo({ top: 0, behavior: 'smooth' })
      setTimeout(() => { lockRef.current = false }, 1000)
    }

    const onWheel = (e) => {
      if (lockRef.current) return
      const wrapperBottom = wrapperRef.current?.getBoundingClientRect().bottom ?? 0
      const isInHero = window.scrollY < (wrapperRef.current?.offsetHeight ?? 0)
      if (e.deltaY > 0 && isInHero) { e.preventDefault(); snapNext() }
      if (e.deltaY < 0 && wrapperBottom > -10 && wrapperBottom < 80) { e.preventDefault(); snapTop() }
    }

    let touchY = 0
    const onTouchStart = (e) => { touchY = e.touches[0].clientY }
    const onTouchEnd = (e) => {
      if (lockRef.current) return
      const diff = touchY - e.changedTouches[0].clientY
      if (Math.abs(diff) < 40) return
      const isInHero = window.scrollY < (wrapperRef.current?.offsetHeight ?? 0)
      const wrapperBottom = wrapperRef.current?.getBoundingClientRect().bottom ?? 0
      if (diff > 0 && isInHero) snapNext()
      if (diff < 0 && wrapperBottom > -10 && wrapperBottom < 80) snapTop()
    }

    window.addEventListener('wheel', onWheel, { passive: false })
    window.addEventListener('touchstart', onTouchStart, { passive: true })
    window.addEventListener('touchend', onTouchEnd, { passive: true })
    return () => {
      window.removeEventListener('scroll', onScroll)
      window.removeEventListener('wheel', onWheel)
      window.removeEventListener('touchstart', onTouchStart)
      window.removeEventListener('touchend', onTouchEnd)
    }
  }, [])

  const stats = [
    { value: '99.9%', label: 'Uptime',   darkColor: 'rgba(44,56,142,0.25)',  darkBorder: 'rgba(74,95,212,0.35)',  darkText: '#7B8FE8',  icon: <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg> },
    { value: '24/7',  label: 'Support',  darkColor: 'rgba(255,103,0,0.15)',  darkBorder: 'rgba(255,103,0,0.35)',  darkText: '#FF8533',  icon: <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.41 2 2 0 0 1 3.6 1.22h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.96a16 16 0 0 0 6 6l.96-.96a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21.73 16.92z"/></svg> },
    { value: '20+',   label: 'Coverage', darkColor: 'rgba(44,56,142,0.20)',  darkBorder: 'rgba(74,95,212,0.30)',  darkText: '#9BA8EE',  icon: <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg> },
    { value: '500+',  label: 'Clients',  darkColor: 'rgba(255,103,0,0.12)',  darkBorder: 'rgba(255,103,0,0.28)',  darkText: '#FFAA66',  icon: <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg> },
  ]

  return (
    <div ref={wrapperRef} className="h-screen sm:h-[180vh]">
      <section
        ref={sectionRef}
        className={`sticky top-0 w-full h-screen overflow-hidden transition-colors duration-300 ${dark ? 'bg-[#0D1117]' : 'bg-[#D0D9EE]'}`}
      >
        {/* Backgrounds */}
        <div className="absolute inset-0 bg-cover bg-center bg-no-repeat" style={{ backgroundImage: `url('${dark ? '/images/heroBGdark.png' : '/images/heroBGLight.png'}')`, opacity: dark ? 0.6 : 0.75 }} />
        <div className="absolute inset-0" style={{ background: dark ? 'rgba(13,17,23,0.50)' : 'rgba(208,217,238,0.40)' }} />
        <div className="absolute inset-0" style={{ background: dark ? 'linear-gradient(to top, rgba(13,17,23,0.80), transparent)' : 'linear-gradient(to top, rgba(208,217,238,0.60), transparent)' }} />
        <div className="absolute inset-0 opacity-60"><NetworkCanvas /></div>
        <WaveDecor />

        {/* Content */}
        <div
          ref={contentRef}
          className="relative z-10 w-full max-w-7xl mx-auto px-4 sm:px-6 pt-[76px] sm:pt-[80px] pb-[140px]"
          style={{ transformOrigin: 'center top', willChange: 'transform, opacity, filter' }}
        >
          {/* Label */}
          <div className="flex flex-col gap-2 mb-4 hero-fade" style={{ animationDelay: '0ms' }}>
            {['ISP · Internet Service Provider', 'System Integrator', 'Web & SaaS Service'].map((label) => (
              <span key={label} className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full border w-fit text-[10px] font-semibold tracking-[0.12em] uppercase"
                style={{ color: dark ? '#7B8FE8' : '#2C388E', borderColor: dark ? 'rgba(74,95,212,0.30)' : 'rgba(44,56,142,0.20)', background: dark ? 'rgba(44,56,142,0.15)' : 'rgba(44,56,142,0.06)' }}>
                <span className="w-1.5 h-1.5 rounded-full shrink-0" style={{ background: '#FF6700' }} />
                {label}
              </span>
            ))}
          </div>

          {/* Headline */}
          <h1 className={`text-[1.5rem] sm:text-3xl md:text-4xl lg:text-5xl font-bold leading-[1.2] mb-3 sm:mb-4 ${dark ? 'text-white' : 'text-gray-900'}`}>
<span
  className="block hero-reveal text-transparent bg-clip-text text-shimmer"
  style={{
    backgroundImage: 'linear-gradient(90deg, #2C388E, #FF6700, #2C388E)',
    backgroundSize: '200% auto',
    animationDelay: '80ms',
  }}
>
  PT.TEKRA LYNX INDONESIA
</span>
            <span className="block hero-reveal" style={{ animationDelay: '80ms' }}>Integrated Technology</span>
            <span className="block hero-glow text-transparent bg-clip-text" style={{ backgroundImage: 'linear-gradient(to right, #FF6700, #2C388E)', animationDelay: '280ms' }}>
              For A Connected Future.
            </span>
          </h1>

          {/* Divider */}
          <div className="w-12 h-px mb-3 sm:mb-4 hero-line" style={{ background: dark ? 'rgba(255,103,0,0.6)' : 'rgba(44,56,142,0.5)', animationDelay: '480ms' }} />

          {/* Subheadline */}
          <p className={`text-xs sm:text-sm leading-relaxed mb-4 sm:mb-6 max-w-xs hero-fade ${dark ? 'text-white/55' : 'text-gray-500'}`} style={{ animationDelay: '520ms' }}>
          High-Speed fiber internet,system integration,
          and managed IT services. One trusted partner for
          your business's connectivity and digital growth.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-wrap gap-2 sm:gap-3 mb-5 sm:mb-7 hero-fade" style={{ animationDelay: '640ms' }}>
            <Link
              to="/contact"
              className="px-4 py-2.5 sm:px-5 sm:py-3 rounded-xl text-white font-semibold text-xs sm:text-sm transition-all duration-200"
              style={{ background: '#FF6700', boxShadow: '0 4px 14px rgba(255,103,0,0.35)' }}
              onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
              onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
            >
              Konsultasi Sekarang
            </Link>
            <Link
              to="/services"
              className={`px-4 py-2.5 sm:px-5 sm:py-3 rounded-xl border font-semibold text-xs sm:text-sm transition-all duration-200 flex items-center gap-2 ${
                dark ? 'border-white/20 text-white' : 'border-[#2C388E]/30 text-[#2C388E] bg-white/40'
              }`}
            >
              Lihat Layanan
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </Link>
          </div>

          {/* Stats */}
          <div className="grid grid-cols-4 gap-2 hero-fade" style={{ animationDelay: '780ms', maxWidth: 360 }}>
            {stats.map((s) => (
              <div
                key={s.label}
                className="relative flex flex-col items-center justify-center gap-1 py-2 px-1.5 rounded-lg border backdrop-blur-sm overflow-hidden"
                style={dark
                  ? { background: s.darkColor, borderColor: s.darkBorder }
                  : { background: 'rgba(255,255,255,0.55)', borderColor: 'rgba(255,255,255,0.65)' }
                }
              >
                <div
                  className="absolute top-0 left-1/2 -translate-x-1/2 w-8 h-px"
                  style={{ background: dark ? `linear-gradient(90deg, transparent, ${s.darkText}60, transparent)` : 'linear-gradient(90deg, transparent, rgba(44,56,142,0.4), transparent)' }}
                />
                <div className="text-sm font-bold leading-none" style={{ color: dark ? s.darkText : '#1a2060' }}>{s.value}</div>
                <div className={`text-[8px] uppercase tracking-wider font-medium ${dark ? 'text-white/40' : 'text-gray-400'}`}>{s.label}</div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  )
}
