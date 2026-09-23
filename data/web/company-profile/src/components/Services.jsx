import { Link } from 'react-router-dom'
import { services } from '../data/services'
import SectionReveal from './SectionReveal'

const icons = {
  wifi: (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M1.5 8.5C5.5 4.5 18.5 4.5 22.5 8.5"/><path d="M5 12c2-2 12-2 14 0"/>
      <path d="M8.5 15.5c1-1 6-1 7 0"/><circle cx="12" cy="19" r="1" fill="currentColor"/>
    </svg>
  ),
  network: (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <circle cx="12" cy="5" r="2"/><circle cx="5" cy="19" r="2"/><circle cx="19" cy="19" r="2"/>
      <path d="M12 7v4M8.5 17.5l3-4.5M15.5 17.5l-3-4.5M7 19h10"/>
    </svg>
  ),
  layers: (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <polygon points="12 2 2 7 12 12 22 7 12 2"/>
      <polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/>
    </svg>
  ),
}

export default function Services() {
  return (
    <section className="py-8 sm:py-16 md:py-20 bg-[#D8E4F5] dark:bg-[#080C14]">
      <div className="w-full max-w-7xl mx-auto px-4 sm:px-6">

        {/* Header */}
        <SectionReveal direction="up" delay={0}>
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-8 sm:mb-12">
            <div>
              <div className="inline-flex items-center gap-2 mb-2">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Our Services</span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                Solusi Infrastruktur Digital
              </h2>
            </div>
            <Link
              to="/services"
              className="self-start sm:self-auto inline-flex items-center gap-2 px-5 py-2.5 rounded-xl border text-sm font-semibold transition-all duration-200 border-[#2C388E]/20 dark:border-white/10 text-gray-700 dark:text-white/70 hover:border-[#2C388E]/50 dark:hover:border-[#FF6700]/40 hover:text-[#2C388E] dark:hover:text-[#FF8533]"
            >
              Lihat Semua
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </Link>
          </div>
        </SectionReveal>

        {/* 2 Col Layout */}
        <div className="grid lg:grid-cols-2 gap-10 lg:gap-16 items-center">

          {/* Kiri — Gambar */}
          <SectionReveal direction="left" delay={0}>
            <div className="w-full max-w-md mx-auto lg:mx-0">
              <img src="/images/our-service.png" alt="Our Services" className="w-full h-auto object-contain" />
            </div>
          </SectionReveal>

          {/* Kanan — 3 Service List */}
          <SectionReveal direction="right" delay={0.1}>
            <div className="flex flex-col gap-4">
              {services.map((s, i) => (
                <Link
                  key={s.id}
                  to="/services"
                  className="group flex items-start gap-4 p-4 sm:p-5 rounded-2xl border transition-all duration-300 border-[#C0D0E8] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] hover:border-[#FF6700]/40 dark:hover:border-[#FF6700]/30 hover:shadow-lg hover:shadow-[#2C388E]/08 dark:hover:shadow-black/20"
                >
                  <div
                    className="w-10 h-10 rounded-xl flex items-center justify-center shrink-0 transition-all duration-300 group-hover:scale-110"
                    style={{ background: i === 0 ? 'rgba(255,103,0,0.10)' : 'rgba(44,56,142,0.09)', color: i === 0 ? '#FF6700' : '#2C388E' }}
                  >
                    {icons[s.icon]}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between gap-2">
                      <h3 className="text-sm font-bold text-gray-900 dark:text-white">{s.title}</h3>
                      {s.badge && (
                        <span className="text-[10px] font-bold px-2 py-0.5 rounded-full shrink-0" style={{ background: 'rgba(255,103,0,0.10)', color: '#FF6700' }}>
                          {s.badge}
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed mt-1 line-clamp-2">{s.desc}</p>
                  </div>
                  <svg className="shrink-0 mt-1 opacity-0 group-hover:opacity-100 transition-all duration-200 -translate-x-1 group-hover:translate-x-0" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#FF6700" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </Link>
              ))}

              <div className="mt-2">
                <Link
                  to="/services"
                  className="inline-flex items-center justify-center gap-2 px-6 py-3 rounded-xl text-white text-sm font-semibold transition-all duration-200"
                  style={{ background: '#FF6700', boxShadow: '0 4px 20px rgba(255,103,0,0.25)' }}
                  onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
                  onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
                >
                  Konsultasi Gratis
                  <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </Link>
              </div>
            </div>
          </SectionReveal>

        </div>
      </div>
    </section>
  )
}
