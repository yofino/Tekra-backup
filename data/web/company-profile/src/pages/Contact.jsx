import { useState } from 'react'
import SectionReveal from '../components/SectionReveal'
import NightSky from '../components/NightSky'

const contactInfo = [
  {
    label: 'Alamat',
    value: 'Jl. Pasir Kaliki No.161 Kota Bandung Indonesia',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
      </svg>
    ),
  },
  {
    label: 'Telepon',
    value: '082121000835',
    href: 'tel:+6282121000835',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.4 2 2 0 0 1 3.6 1.22h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.78a16 16 0 0 0 6.29 6.29l.96-.96a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/>
      </svg>
    ),
  },
  {
    label: 'Email',
    value: 'info@tekra.id',
    href: 'mailto:info@tekra.id',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
      </svg>
    ),
  },
  {
    label: 'Jam Operasional',
    value: 'NOC 24/7 · Kantor: Senin–Jumat, 08.00–17.00 WIB',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>
      </svg>
    ),
  },
]

const channels = [
  {
    label: 'WhatsApp',
    sub: 'Respons cepat via chat',
    href: 'https://wa.me/6282121000835',
    color: '#25D366',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347z"/>
        <path d="M12 0C5.373 0 0 5.373 0 12c0 2.127.558 4.126 1.533 5.858L.057 23.5l5.797-1.52A11.95 11.95 0 0 0 12 24c6.627 0 12-5.373 12-12S18.627 0 12 0zm0 21.818a9.818 9.818 0 0 1-5.006-1.371l-.36-.213-3.44.902.918-3.352-.234-.374A9.818 9.818 0 1 1 12 21.818z"/>
      </svg>
    ),
  },
  {
    label: 'Email Sales',
    sub: 'Penawaran & konsultasi',
    href: 'mailto:info@tekra.id',
    color: '#2C388E',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
      </svg>
    ),
  },
  {
    label: 'Tiket Support',
    sub: 'Bantuan teknis 24/7',
    href: 'mailto:info@tekra.id',
    color: '#FF6700',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
      </svg>
    ),
  },
]

const subjects = [
  'Konsultasi Layanan Internet',
  'Penawaran Harga',
  'Informasi Colocation',
  'Dukungan Teknis',
  'Kemitraan & Reseller',
  'Lainnya',
]

function Field({ label, name, type = 'text', value, onChange, placeholder, required }) {
  return (
    <div>
      <label className="block text-xs font-semibold text-gray-600 dark:text-white/50 mb-1.5">{label}</label>
      <input
        type={type} name={name} value={value} onChange={onChange}
        placeholder={placeholder} required={required}
        className="w-full px-4 py-3 rounded-xl text-sm border border-[#C8D4EC] dark:border-white/[0.08] bg-white dark:bg-white/[0.04] text-gray-900 dark:text-white placeholder-gray-300 dark:placeholder-white/20 focus:outline-none focus:border-[#2C388E] dark:focus:border-[#7B8FE8] transition-colors"
      />
    </div>
  )
}

export default function Contact() {
  const [form, setForm] = useState({ name: '', email: '', company: '', phone: '', subject: '', message: '' })
  const [sent, setSent] = useState(false)

  const handleChange = e => setForm(f => ({ ...f, [e.target.name]: e.target.value }))
  const handleSubmit = e => { e.preventDefault(); setSent(true) }
  const handleReset = () => { setSent(false); setForm({ name: '', email: '', company: '', phone: '', subject: '', message: '' }) }

  return (
    <main className="bg-[#EBF0FA] dark:bg-[#0D1117] min-h-screen">
      <NightSky />

      {/* ── Hero ── */}
      <section className="relative pt-[76px] pb-16 sm:pb-24 bg-[#D0D9EE] dark:bg-[#0D1117] overflow-hidden">
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-0 right-0 w-[600px] h-[600px] rounded-full opacity-[0.08]"
            style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)', transform: 'translate(25%, -25%)' }} />
          <div className="absolute bottom-0 left-0 w-[500px] h-[500px] rounded-full opacity-[0.07]"
            style={{ background: 'radial-gradient(circle, #2C388E, transparent 65%)', transform: 'translate(-25%, 25%)' }} />
          <div className="absolute inset-0 opacity-[0.03]"
            style={{ backgroundImage: 'linear-gradient(#2C388E 1px, transparent 1px), linear-gradient(90deg, #2C388E 1px, transparent 1px)', backgroundSize: '60px 60px' }} />
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 pt-12 sm:pt-20">
          <SectionReveal direction="up" delay={0}>
            <div className="inline-flex items-center gap-2 mb-5 px-3 py-1.5 rounded-full border border-[#FF6700]/25 bg-[#FF6700]/[0.07]">
              <span className="w-1.5 h-1.5 rounded-full animate-pulse" style={{ background: '#FF6700' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase" style={{ color: '#FF6700' }}>Hubungi Kami</span>
            </div>
            <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black text-gray-900 dark:text-white leading-[1.1] mb-5 max-w-3xl">
              Kami Siap{' '}
              <span className="text-transparent bg-clip-text" style={{ backgroundImage: 'linear-gradient(135deg, #FF6700 0%, #2C388E 100%)' }}>
                Membantu Anda
              </span>
            </h1>
            <p className="text-sm sm:text-base text-gray-500 dark:text-white/50 leading-relaxed max-w-xl mb-10">
              Konsultasikan kebutuhan jaringan bisnis Anda bersama tim ahli kami. Respons cepat, solusi tepat.
            </p>
          </SectionReveal>

          {/* channel quick links */}
          <SectionReveal direction="up" delay={0.1}>
            <div className="flex flex-wrap gap-3">
              {channels.map(ch => (
                <a key={ch.label} href={ch.href} target="_blank" rel="noopener noreferrer"
                  className="flex items-center gap-2 px-4 py-2.5 rounded-xl border border-[#C0D0E8] dark:border-white/[0.08] bg-white/60 dark:bg-white/[0.04] backdrop-blur-sm hover:scale-[1.02] transition-all duration-200"
                  style={{ color: ch.color }}>
                  <span>{ch.icon}</span>
                  <span className="text-xs font-semibold text-gray-700 dark:text-white/70">{ch.label}</span>
                </a>
              ))}
            </div>
          </SectionReveal>
        </div>
      </section>

      {/* ── Form + Info ── */}
      <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <div className="grid lg:grid-cols-5 gap-8 xl:gap-14">

            {/* ── Form ── */}
            <div className="lg:col-span-3">
              <SectionReveal direction="up" delay={0}>
                <div className="rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] overflow-hidden">
                  {/* form header */}
                  <div className="px-6 sm:px-8 py-5 border-b border-[#E0E8F5] dark:border-white/[0.06]"
                    style={{ background: 'linear-gradient(135deg, rgba(44,56,142,0.05), rgba(255,103,0,0.03))' }}>
                    <h2 className="text-base font-bold text-gray-900 dark:text-white">Kirim Pesan</h2>
                    <p className="text-xs text-gray-500 dark:text-white/40 mt-0.5">Tim kami akan merespons dalam 1×24 jam kerja.</p>
                  </div>

                  <div className="p-6 sm:p-8">
                    {sent ? (
                      <div className="flex flex-col items-center justify-center py-14 text-center gap-5">
                        <div className="w-16 h-16 rounded-2xl flex items-center justify-center"
                          style={{ background: 'rgba(255,103,0,0.10)', color: '#FF6700' }}>
                          <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>
                          </svg>
                        </div>
                        <div>
                          <p className="text-lg font-bold text-gray-900 dark:text-white">Pesan Terkirim!</p>
                          <p className="text-sm text-gray-500 dark:text-white/40 mt-1 max-w-xs">
                            Terima kasih telah menghubungi kami. Tim kami akan segera merespons.
                          </p>
                        </div>
                        <button onClick={handleReset}
                          className="px-5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-200"
                          style={{ background: 'rgba(44,56,142,0.10)', color: '#2C388E' }}>
                          Kirim Pesan Lain
                        </button>
                      </div>
                    ) : (
                      <form onSubmit={handleSubmit} className="space-y-4">
                        <div className="grid sm:grid-cols-2 gap-4">
                          <Field label="Nama Lengkap *" name="name" value={form.name} onChange={handleChange} placeholder="John Doe" required />
                          <Field label="Email *" name="email" type="email" value={form.email} onChange={handleChange} placeholder="john@perusahaan.com" required />
                        </div>
                        <div className="grid sm:grid-cols-2 gap-4">
                          <Field label="Perusahaan" name="company" value={form.company} onChange={handleChange} placeholder="PT. Contoh Maju" />
                          <Field label="No. Telepon" name="phone" value={form.phone} onChange={handleChange} placeholder="+62 812 3456 7890" />
                        </div>
                        <div>
                          <label className="block text-xs font-semibold text-gray-600 dark:text-white/50 mb-1.5">Subjek *</label>
                          <select name="subject" value={form.subject} onChange={handleChange} required
                            className="w-full px-4 py-3 rounded-xl text-sm border border-[#C8D4EC] dark:border-white/[0.08] bg-white dark:bg-white/[0.04] text-gray-900 dark:text-white focus:outline-none focus:border-[#2C388E] dark:focus:border-[#7B8FE8] transition-colors">
                            <option value="">Pilih subjek...</option>
                            {subjects.map(s => <option key={s}>{s}</option>)}
                          </select>
                        </div>
                        <div>
                          <label className="block text-xs font-semibold text-gray-600 dark:text-white/50 mb-1.5">Pesan *</label>
                          <textarea name="message" value={form.message} onChange={handleChange} required rows={5}
                            placeholder="Ceritakan kebutuhan jaringan bisnis Anda..."
                            className="w-full px-4 py-3 rounded-xl text-sm border border-[#C8D4EC] dark:border-white/[0.08] bg-white dark:bg-white/[0.04] text-gray-900 dark:text-white placeholder-gray-300 dark:placeholder-white/20 focus:outline-none focus:border-[#2C388E] dark:focus:border-[#7B8FE8] transition-colors resize-none" />
                        </div>
                        <button type="submit"
                          className="w-full py-3.5 rounded-xl text-white font-bold text-sm flex items-center justify-center gap-2 transition-all duration-200"
                          style={{ background: '#FF6700', boxShadow: '0 4px 20px rgba(255,103,0,0.30)' }}
                          onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
                          onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}>
                          Kirim Pesan
                          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                        </button>
                      </form>
                    )}
                  </div>
                </div>
              </SectionReveal>
            </div>

            {/* ── Info Panel ── */}
            <div className="lg:col-span-2 flex flex-col gap-5">

              {/* contact info */}
              <SectionReveal direction="up" delay={0.08}>
                <div className="rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] overflow-hidden">
                  <div className="px-6 py-4 border-b border-[#E0E8F5] dark:border-white/[0.06]">
                    <h3 className="text-sm font-bold text-gray-900 dark:text-white">Informasi Kontak</h3>
                  </div>
                  <div className="p-6 space-y-4">
                    {contactInfo.map(c => (
                      <div key={c.label} className="flex items-start gap-3.5">
                        <div className="w-9 h-9 rounded-xl flex items-center justify-center shrink-0"
                          style={{ background: 'rgba(44,56,142,0.08)', color: '#2C388E' }}>
                          {c.icon}
                        </div>
                        <div>
                          <p className="text-[10px] font-bold uppercase tracking-wider text-gray-400 dark:text-white/30 mb-0.5">{c.label}</p>
                          {c.href ? (
                            <a href={c.href} className="text-xs text-gray-700 dark:text-white/70 hover:text-[#2C388E] dark:hover:text-[#7B8FE8] transition-colors leading-relaxed">
                              {c.value}
                            </a>
                          ) : (
                            <p className="text-xs text-gray-700 dark:text-white/70 leading-relaxed">{c.value}</p>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </SectionReveal>

              {/* channels */}
              <SectionReveal direction="up" delay={0.14}>
                <div className="rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] overflow-hidden">
                  <div className="px-6 py-4 border-b border-[#E0E8F5] dark:border-white/[0.06]">
                    <h3 className="text-sm font-bold text-gray-900 dark:text-white">Hubungi Langsung</h3>
                  </div>
                  <div className="p-4 flex flex-col gap-2">
                    {channels.map(ch => (
                      <a key={ch.label} href={ch.href} target="_blank" rel="noopener noreferrer"
                        className="group flex items-center gap-3.5 p-3.5 rounded-xl border border-transparent hover:border-current transition-all duration-200"
                        style={{ color: ch.color }}>
                        <div className="w-10 h-10 rounded-xl flex items-center justify-center shrink-0 transition-all duration-200 group-hover:scale-110"
                          style={{ background: `${ch.color}14` }}>
                          {ch.icon}
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-xs font-bold text-gray-800 dark:text-white group-hover:text-current transition-colors">{ch.label}</p>
                          <p className="text-[11px] text-gray-400 dark:text-white/30">{ch.sub}</p>
                        </div>
                        <svg className="opacity-0 group-hover:opacity-100 transition-opacity shrink-0" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                          <path d="M5 12h14M12 5l7 7-7 7"/>
                        </svg>
                      </a>
                    ))}
                  </div>
                </div>
              </SectionReveal>

              {/* NOC live badge */}
              <SectionReveal direction="up" delay={0.2}>
                <div className="relative overflow-hidden rounded-2xl p-5 flex items-center gap-4"
                  style={{ background: 'linear-gradient(135deg, #1a2260, #2C388E)' }}>
                  <div className="absolute inset-0 pointer-events-none">
                    <div className="absolute -top-8 -right-8 w-32 h-32 rounded-full opacity-20"
                      style={{ background: 'radial-gradient(circle, #FF6700, transparent 70%)' }} />
                  </div>
                  <div className="relative w-11 h-11 rounded-xl flex items-center justify-center shrink-0"
                    style={{ background: 'rgba(255,103,0,0.20)', color: '#FF6700' }}>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                      <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
                    </svg>
                  </div>
                  <div className="relative">
                    <div className="flex items-center gap-2 mb-0.5">
                      <p className="text-xs font-bold text-white">NOC 24/7</p>
                      <span className="w-1.5 h-1.5 rounded-full bg-green-400 animate-pulse" />
                    </div>
                    <p className="text-[11px] text-white/50 leading-relaxed">Tim teknis kami siaga sepanjang waktu untuk memastikan jaringan Anda selalu optimal.</p>
                  </div>
                </div>
              </SectionReveal>
            </div>
          </div>
        </div>
      </section>

      {/* ── Map ── */}
      <section className="py-16 sm:py-24 bg-[#D8E4F5] dark:bg-[#0D1117]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-8">
              <div>
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                  <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Lokasi Kami</span>
                </div>
                <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Kantor Pusat</h2>
              </div>
              <a href="https://maps.google.com/?q=Jl.+PasirKaliki+Cicendo+No161+Bandung" target="_blank" rel="noopener noreferrer"
                className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-semibold border border-[#C8D4EC] dark:border-white/[0.08] text-gray-700 dark:text-white/70 hover:border-[#2C388E] hover:text-[#2C388E] dark:hover:text-[#7B8FE8] transition-all duration-200">
                Buka di Maps
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/><polyline points="15 3 21 3 21 9"/><line x1="10" y1="14" x2="21" y2="3"/></svg>
              </a>
            </div>

            <div className="w-full h-72 sm:h-96 rounded-2xl overflow-hidden border border-[#C8D4EC] dark:border-white/[0.07] shadow-lg">
              <iframe
                title="Lokasi Tekra"
                src="https://www.google.com/maps?q=Jl.+Pasir+Kaliki+No.161,+Pamoyanan,+Cicendo,+Bandung,+Jawa+Barat&output=embed"
                width="100%" height="100%" style={{ border: 0, filter: 'grayscale(15%) contrast(1.05)' }}
                allowFullScreen loading="lazy" referrerPolicy="no-referrer-when-downgrade"
              />
            </div>
          </SectionReveal>
        </div>
      </section>

    </main>
  )
}
