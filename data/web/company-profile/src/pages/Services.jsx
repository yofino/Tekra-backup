import { useState } from 'react'
import { Link } from 'react-router-dom'
import { AnimatePresence, motion } from 'framer-motion'
import { services } from '../data/services'
import SectionReveal from '../components/SectionReveal'
import NightSky from '../components/NightSky'
import { useTheme } from '../context/ThemeContext'

const icons = {
  wifi: (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <path d="M1.5 8.5C5.5 4.5 18.5 4.5 22.5 8.5"/><path d="M5 12c2-2 12-2 14 0"/>
      <path d="M8.5 15.5c1-1 6-1 7 0"/><circle cx="12" cy="19" r="1" fill="currentColor"/>
    </svg>
  ),
  network: (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <circle cx="12" cy="5" r="2"/><circle cx="5" cy="19" r="2"/><circle cx="19" cy="19" r="2"/>
      <path d="M12 7v4M8.5 17.5l3-4.5M15.5 17.5l-3-4.5M7 19h10"/>
    </svg>
  ),
  layers: (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
      <polygon points="12 2 2 7 12 12 22 7 12 2"/>
      <polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/>
    </svg>
  ),
}

const steps = [
  { num: '01', title: 'Konsultasi Gratis', desc: 'Ceritakan kebutuhan bisnis Anda. Tim kami menganalisis dan menyusun rekomendasi solusi yang tepat.' },
  { num: '02', title: 'Desain Solusi', desc: 'Kami merancang arsitektur jaringan optimal sesuai skala, anggaran, dan target pertumbuhan bisnis Anda.' },
  { num: '03', title: 'Implementasi', desc: 'Teknisi bersertifikat kami memasang dan mengkonfigurasi seluruh infrastruktur dengan downtime minimal.' },
  { num: '04', title: 'Monitoring & Support', desc: 'NOC 24/7 memantau jaringan Anda secara proaktif dan siap merespons setiap insiden dalam hitungan menit.' },
]

const highlights = [
  { value: '99.9%', label: 'Uptime SLA', icon: <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg> },
  { value: '< 15 min', label: 'Response Time', icon: <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg> },
  { value: '24/7', label: 'NOC Support', icon: <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg> },
  { value: '20+', label: 'Kota Coverage', icon: <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="10" r="3"/><path d="M12 2a8 8 0 0 0-8 8c0 5.25 8 14 8 14s8-8.75 8-14a8 8 0 0 0-8-8z"/></svg> },
]

function ServiceModal({ service, onClose }) {
  return (
    <motion.div
      className="fixed inset-0 z-[100] flex items-center justify-center px-4"
      initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
      transition={{ duration: 0.2 }}
      onClick={onClose}
    >
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" />
      <motion.div
        className="relative w-full max-w-lg rounded-2xl overflow-hidden bg-white dark:bg-[#0D1117] border border-[#C8D4EC] dark:border-white/[0.08] shadow-2xl"
        initial={{ scale: 0.92, opacity: 0, y: 20 }} animate={{ scale: 1, opacity: 1, y: 0 }} exit={{ scale: 0.92, opacity: 0, y: 20 }}
        transition={{ duration: 0.25, ease: [0.22, 1, 0.36, 1] }}
        onClick={e => e.stopPropagation()}
      >
        <div className="h-1 w-full" style={{ background: 'linear-gradient(90deg, #FF6700, #2C388E)' }} />
        <div className="p-6 sm:p-8">
          <div className="flex items-start justify-between mb-6">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-2xl flex items-center justify-center shrink-0" style={{ background: 'rgba(44,56,142,0.09)', color: '#2C388E' }}>
                {icons[service.icon]}
              </div>
              <div>
                <h3 className="text-lg font-bold text-gray-900 dark:text-white">{service.title}</h3>
                <p className="text-xs text-gray-500 dark:text-white/40 mt-0.5">{service.desc}</p>
              </div>
            </div>
            <button onClick={onClose} className="w-8 h-8 rounded-xl flex items-center justify-center border border-[#C8D4EC] dark:border-white/[0.08] text-gray-400 dark:text-white/40 hover:text-gray-700 dark:hover:text-white transition-all duration-200 shrink-0 ml-3">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 6L6 18M6 6l12 12"/></svg>
            </button>
          </div>
          <div className="mb-5">
            <p className="text-[10px] font-bold uppercase tracking-widest text-gray-400 dark:text-white/30 mb-3">Keunggulan</p>
            <ul className="space-y-2">
              {service.features.map(f => (
                <li key={f} className="flex items-center gap-2.5 text-sm text-gray-700 dark:text-white/70">
                  <span className="w-5 h-5 rounded-full flex items-center justify-center shrink-0" style={{ background: 'rgba(255,103,0,0.10)' }}>
                    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#FF6700" strokeWidth="3"><polyline points="20 6 9 17 4 12"/></svg>
                  </span>
                  {f}
                </li>
              ))}
            </ul>
          </div>
          <div className="mb-7">
            <p className="text-[10px] font-bold uppercase tracking-widest text-gray-400 dark:text-white/30 mb-3">Produk</p>
            <div className="grid grid-cols-2 gap-2">
              {service.produk.map(p => (
                <div key={p} className="flex items-center gap-2 px-3 py-2.5 rounded-xl border border-[#C8D4EC] dark:border-white/[0.07] bg-[#EBF0FA] dark:bg-white/[0.03]">
                  <span className="w-1.5 h-1.5 rounded-full shrink-0" style={{ background: '#2C388E' }} />
                  <span className="text-xs font-medium text-gray-700 dark:text-white/70">{p}</span>
                </div>
              ))}
            </div>
          </div>
          <Link to="/contact" onClick={onClose}
            className="flex items-center justify-center gap-2 w-full py-3 rounded-xl text-white text-sm font-semibold transition-all duration-200"
            style={{ background: '#FF6700', boxShadow: '0 4px 20px rgba(255,103,0,0.30)' }}
            onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
            onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
          >
            Hubungi Kami
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </Link>
        </div>
      </motion.div>
    </motion.div>
  )
}

function ServiceCard({ s, index, onSelect }) {
  const [hovered, setHovered] = useState(false)
  const { dark } = useTheme()
  const isFeatured = s.badge === 'Unggulan'

  const borderColor = hovered ? 'rgba(255,103,0,0.45)' : isFeatured ? 'rgba(255,103,0,0.35)' : dark ? 'rgba(255,255,255,0.07)' : 'rgba(192,208,232,0.9)'
  const bgColor = hovered
    ? dark ? 'linear-gradient(160deg, rgba(255,103,0,0.07), rgba(44,56,142,0.12))' : 'linear-gradient(160deg, rgba(255,103,0,0.04), rgba(44,56,142,0.06))'
    : dark ? 'rgba(255,255,255,0.03)' : 'rgba(255,255,255,0.85)'

  return (
    <SectionReveal direction="up" delay={index * 0.06}>
      <div
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
        className="relative flex flex-col rounded-2xl overflow-hidden h-full transition-all duration-300"
        style={{ border: `1.5px solid ${borderColor}`, background: bgColor, boxShadow: hovered ? dark ? '0 12px 40px rgba(0,0,0,0.35)' : '0 12px 40px rgba(44,56,142,0.12)' : 'none' }}
      >
        <div className="h-[3px] w-full transition-opacity duration-300" style={{ background: 'linear-gradient(90deg, #FF6700, #2C388E)', opacity: hovered || isFeatured ? 1 : 0 }} />
        <div className="flex flex-col p-6 flex-1">
          <div className="flex items-start justify-between mb-5">
            <div className="w-12 h-12 rounded-2xl flex items-center justify-center transition-all duration-300"
              style={hovered ? { background: '#FF6700', color: '#fff', boxShadow: '0 6px 20px rgba(255,103,0,0.35)' } : dark ? { background: 'rgba(44,56,142,0.20)', color: '#7B8FE8' } : { background: 'rgba(44,56,142,0.09)', color: '#2C388E' }}>
              {icons[s.icon]}
            </div>
            {s.badge && (
              <span className="text-[10px] font-bold px-2.5 py-1 rounded-full"
                style={s.badge === 'Unggulan' ? { background: 'rgba(255,103,0,0.12)', color: '#FF6700' } : { background: 'rgba(44,56,142,0.10)', color: dark ? '#7B8FE8' : '#2C388E' }}>
                {s.badge}
              </span>
            )}
          </div>
          <h3 className="text-base font-bold text-gray-900 dark:text-white mb-2">{s.title}</h3>
          <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed mb-5 flex-1">{s.desc}</p>
          <ul className="space-y-2 mb-6">
            {s.features.map(f => (
              <li key={f} className="flex items-center gap-2.5 text-xs text-gray-600 dark:text-white/55">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#FF6700" strokeWidth="2.5"><polyline points="20 6 9 17 4 12"/></svg>
                {f}
              </li>
            ))}
          </ul>
          <ul className="space-y-2 mb-4">
            {s.produk.map(f => (
              <li key={f} className="flex items-center gap-2.5 text-xs text-gray-600 dark:text-white/55">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#FF6700" strokeWidth="2.5"><polyline points="20 6 9 17 4 12"/></svg>
                {f}
              </li>
            ))}
          </ul>
          <button
            onClick={e => { e.stopPropagation(); onSelect(s) }}
            className="inline-flex items-center gap-1.5 text-xs font-semibold transition-all duration-200 mt-auto"
            style={{ color: hovered ? '#FF6700' : dark ? '#7B8FE8' : '#2C388E' }}
          >
            More
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
          </button>
        </div>
      </div>
    </SectionReveal>
  )
}

export default function Services() {
  const { dark } = useTheme()
  const [selected, setSelected] = useState(null)

  return (
    <main className="bg-[#EBF0FA] dark:bg-[#0D1117] min-h-screen">
      <NightSky />

      {/* Hero */}
      <section className="relative pt-[76px] pb-16 sm:pb-24 bg-[#D0D9EE] dark:bg-[#0D1117] overflow-hidden">
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-0 right-0 w-[600px] h-[600px] rounded-full opacity-[0.08]" style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)', transform: 'translate(25%, -25%)' }} />
          <div className="absolute bottom-0 left-0 w-[500px] h-[500px] rounded-full opacity-[0.07]" style={{ background: 'radial-gradient(circle, #2C388E, transparent 65%)', transform: 'translate(-25%, 25%)' }} />
          <div className="absolute inset-0 opacity-[0.03]" style={{ backgroundImage: 'linear-gradient(#2C388E 1px, transparent 1px), linear-gradient(90deg, #2C388E 1px, transparent 1px)', backgroundSize: '60px 60px' }} />
        </div>
        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 pt-12 sm:pt-20">
          <SectionReveal direction="up" delay={0}>
            <div className="inline-flex items-center gap-2 mb-5 px-3 py-1.5 rounded-full border border-[#FF6700]/25 bg-[#FF6700]/[0.07]">
              <span className="w-1.5 h-1.5 rounded-full animate-pulse" style={{ background: '#FF6700' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase" style={{ color: '#FF6700' }}>Layanan Kami</span>
            </div>
            <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black text-gray-900 dark:text-white leading-[1.1] mb-5 max-w-3xl">
              Solusi Jaringan{' '}
              <span className="text-transparent bg-clip-text" style={{ backgroundImage: 'linear-gradient(135deg, #FF6700 0%, #2C388E 100%)' }}>untuk Setiap Skala</span>
            </h1>
            <p className="text-sm sm:text-base text-gray-500 dark:text-white/50 leading-relaxed max-w-xl mb-10">
              Dari koneksi internet dedicated hingga managed network enterprise — infrastruktur digital yang andal, skalabel, dan didukung tim ahli 24/7.
            </p>
          </SectionReveal>
          <SectionReveal direction="up" delay={0.1}>
            <div className="flex flex-wrap gap-3">
              {highlights.map(h => (
                <div key={h.label} className="flex items-center gap-2.5 px-4 py-2.5 rounded-xl border border-[#C0D0E8] dark:border-white/[0.08] bg-white/60 dark:bg-white/[0.04] backdrop-blur-sm">
                  <span style={{ color: '#FF6700' }}>{h.icon}</span>
                  <span className="text-sm font-bold text-gray-900 dark:text-white">{h.value}</span>
                  <span className="text-[11px] text-gray-400 dark:text-white/35">{h.label}</span>
                </div>
              ))}
            </div>
          </SectionReveal>
        </div>
      </section>

      {/* Services Grid */}
      <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-12">
              <div>
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                  <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>3 Layanan</span>
                </div>
                <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Pilih Solusi yang Tepat</h2>
              </div>
              <Link to="/contact"
                className="self-start sm:self-auto inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-white text-sm font-semibold transition-all duration-200"
                style={{ background: '#2C388E' }}
                onMouseEnter={e => e.currentTarget.style.background = '#1e2a6e'}
                onMouseLeave={e => e.currentTarget.style.background = '#2C388E'}
              >
                Konsultasi Gratis
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
              </Link>
            </div>
          </SectionReveal>
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {services.map((s, i) => <ServiceCard key={s.id} s={s} index={i} onSelect={setSelected} />)}
          </div>
        </div>
      </section>

      {/* Proses Kerja */}
      <section className="py-16 sm:py-24 bg-[#D8E4F5] dark:bg-[#0D1117] overflow-hidden">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="text-center mb-14">
              <div className="inline-flex items-center gap-2 mb-3">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Cara Kerja</span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-3">Proses Onboarding Kami</h2>
              <p className="text-sm text-gray-500 dark:text-white/40 max-w-md mx-auto">Dari konsultasi hingga jaringan aktif — proses yang transparan dan efisien.</p>
            </div>
          </SectionReveal>
          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5 relative">
            <div className="hidden lg:block absolute top-10 left-[calc(12.5%+24px)] right-[calc(12.5%+24px)] h-px" style={{ background: 'linear-gradient(90deg, #FF6700, #2C388E)' }} />
            {steps.map((s, i) => (
              <SectionReveal key={s.num} direction="up" delay={i * 0.08}>
                <div className="relative flex flex-col p-6 rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] h-full">
                  <div className="w-12 h-12 rounded-2xl flex items-center justify-center mb-5 text-sm font-black relative z-10"
                    style={{ background: i % 2 === 0 ? '#2C388E' : '#FF6700', color: '#fff', boxShadow: `0 4px 16px ${i % 2 === 0 ? 'rgba(44,56,142,0.30)' : 'rgba(255,103,0,0.30)'}` }}>
                    {s.num}
                  </div>
                  <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-2">{s.title}</h3>
                  <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed">{s.desc}</p>
                </div>
              </SectionReveal>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="relative overflow-hidden rounded-3xl" style={{ background: 'linear-gradient(135deg, #1a2260 0%, #2C388E 50%, #1a2260 100%)' }}>
              <div className="absolute inset-0 pointer-events-none">
                <div className="absolute -top-20 -right-20 w-80 h-80 rounded-full opacity-20" style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)' }} />
                <div className="absolute -bottom-16 -left-16 w-64 h-64 rounded-full opacity-15" style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)' }} />
              </div>
              <div className="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-8 p-8 sm:p-12">
                <div className="text-center lg:text-left">
                  <p className="text-[11px] font-semibold tracking-[0.2em] uppercase mb-3" style={{ color: '#FF6700' }}>Mulai Sekarang</p>
                  <h2 className="text-2xl sm:text-3xl font-black text-white mb-3">Tidak Yakin Layanan Mana yang Tepat?</h2>
                  <p className="text-white/55 text-sm max-w-md">Tim konsultan kami siap membantu Anda memilih solusi yang paling sesuai dengan kebutuhan bisnis.</p>
                </div>
                <div className="flex flex-col sm:flex-row gap-3 shrink-0">
                  <Link to="/contact"
                    className="inline-flex items-center justify-center gap-2 px-7 py-3.5 rounded-xl text-white font-bold text-sm transition-all duration-200"
                    style={{ background: '#FF6700', boxShadow: '0 4px 24px rgba(255,103,0,0.45)' }}
                    onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
                    onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
                  >
                    Konsultasi Gratis
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                  </Link>
                </div>
              </div>
            </div>
          </SectionReveal>
        </div>
      </section>

      {/* Modal */}
      <AnimatePresence>
        {selected && <ServiceModal service={selected} onClose={() => setSelected(null)} />}
      </AnimatePresence>

    </main>
  )
}
