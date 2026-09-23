import SectionReveal from '../components/SectionReveal'
import NightSky from '../components/NightSky'

const stats = [
  { value: '2017', label: 'Berdiri Sejak' },
  { value: '500+', label: 'Klien Aktif' },
  { value: '20+',  label: 'Kota Coverage' },
  { value: '99.9%',label: 'Uptime SLA' },
]

const values = [
  {
    title: 'Integritas',
    desc: 'Kami berkomitmen pada kejujuran dan transparansi dalam setiap layanan yang kami berikan kepada klien.',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
        <path d="M9 12l2 2 4-4"/>
      </svg>
    ),
  },
  {
    title: 'Inovasi',
    desc: 'Terus mengadopsi teknologi terkini untuk menghadirkan solusi jaringan yang relevan dan kompetitif.',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <circle cx="12" cy="12" r="3"/>
        <path d="M12 1v4M12 19v4M4.22 4.22l2.83 2.83M16.95 16.95l2.83 2.83M1 12h4M19 12h4M4.22 19.78l2.83-2.83M16.95 7.05l2.83-2.83"/>
      </svg>
    ),
  },
  {
    title: 'Keandalan',
    desc: 'Infrastruktur kami dirancang dengan redundansi penuh untuk memastikan layanan tetap berjalan tanpa gangguan.',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
      </svg>
    ),
  },
  {
    title: 'Kolaborasi',
    desc: 'Kami percaya bahwa kemitraan yang kuat dengan klien adalah kunci keberhasilan jangka panjang.',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
        <circle cx="9" cy="7" r="4"/>
        <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
      </svg>
    ),
  },
]

const milestones = [
  { year: '2017', title: 'Pendirian Tekra', desc: 'Tekra didirikan dengan visi menghadirkan konektivitas internet berkualitas tinggi untuk bisnis di Indonesia.' },
  { year: '2020', title: 'Ekspansi Jaringan', desc: 'Memperluas jangkauan ke titik ruas kota Bandung dan Kabupaten Bandung dengan membangun infrastruktur fiber optik sendiri.' },
  { year: '2022', title: 'Unit Bisnis System Integrator', desc: 'Memulai unit bisnis System Integrator yang berkolaborasi dengan ISP dan menjadi layanan Managed Service One Stop Solution IT Service untuk klien korporat.' },
  { year: '2026', title: 'AS Number & IPv6', desc: 'Mendapatkan Autonomous System Number dan blok IPv6 resmi, memperkuat posisi sebagai ISP tier-1.' },
]

export default function About() {
  return (
    <main className="bg-[#EBF0FA] dark:bg-[#0D1117] min-h-screen">
      <NightSky />

      {/* Hero Section */}
      <section className="relative pt-[76px] pb-16 sm:pb-20 overflow-hidden bg-[#D0D9EE] dark:bg-[#0D1117]">
        {/* bg accent */}
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-0 right-0 w-[500px] h-[500px] rounded-full opacity-10" style={{ background: 'radial-gradient(circle, #FF6700, transparent 70%)', transform: 'translate(30%, -30%)' }} />
          <div className="absolute bottom-0 left-0 w-[400px] h-[400px] rounded-full opacity-10" style={{ background: 'radial-gradient(circle, #2C388E, transparent 70%)', transform: 'translate(-30%, 30%)' }} />
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 pt-10 sm:pt-16">
          <SectionReveal direction="up" delay={0}>
            <div className="inline-flex items-center gap-2 mb-4">
              <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
              <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Tentang Kami</span>
            </div>
            <h1 className="text-2xl sm:text-4xl lg:text-5xl font-bold text-gray-900 dark:text-white leading-tight mb-4 max-w-2xl">
              Membangun Konektivitas{' '}
              <span className="text-transparent bg-clip-text" style={{ backgroundImage: 'linear-gradient(to right, #FF6700, #2C388E)' }}>
                yang Dapat Diandalkan
              </span>
            </h1>
            <p className="text-sm sm:text-base text-gray-500 dark:text-white/50 leading-relaxed max-w-xl">
              Kami percaya bahwa konektivitas dan teknologi digital adalah fondasi setiap bisnis modern. Sebagai penyedia layanan internet (ISP), mitra integrasi sistem (System Integrator), sekaligus pengembang solusi Web & SaaS, Tekra Lynx Indonesia sejak 2017 hadir untuk menjembatani kebutuhan infrastruktur jaringan dan transformasi digital Anda.dalam satu atap, satu mitra terpercaya.
            </p>
          </SectionReveal>

          {/* Stats row */}
          <SectionReveal direction="up" delay={0.1}>
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mt-10 sm:mt-14 max-w-2xl">
              {stats.map((s) => (
                <div key={s.label} className="flex flex-col gap-1 p-4 rounded-2xl bg-white/60 dark:bg-white/[0.04] border border-white/80 dark:border-white/[0.08] backdrop-blur-sm">
                  <span className="text-2xl sm:text-3xl font-bold" style={{ color: '#2C388E' }}>{s.value}</span>
                  <span className="text-[11px] text-gray-500 dark:text-white/40 font-medium uppercase tracking-wider">{s.label}</span>
                </div>
              ))}
            </div>
          </SectionReveal>
        </div>
      </section>

      {/* Visi & Misi */}
      <section className="py-14 sm:py-20 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <div className="grid lg:grid-cols-2 gap-6 sm:gap-8">

            <SectionReveal direction="up" delay={0}>
              <div className="h-full p-6 sm:p-8 rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/50 dark:bg-white/[0.03]">
                <div className="w-10 h-10 rounded-xl flex items-center justify-center mb-5" style={{ background: 'rgba(255,103,0,0.12)', color: '#FF6700' }}>
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="2" y1="12" x2="22" y2="12"/>
                    <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/>
                  </svg>
                </div>
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-1.5 h-1.5 rounded-full" style={{ background: '#FF6700' }} />
                  <span className="text-xs font-semibold tracking-[0.18em] uppercase" style={{ color: '#FF6700' }}>Visi</span>
                </div>
                <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white mb-3">
                   To be Indonesia's leading integrated technology partner, connecting people and businesses to a smarter digital future.
                </h3>
                {/* <p className="text-sm text-gray-500 dark:text-white/50 leading-relaxed">
                  Menjadi penyedia infrastruktur jaringan terdepan yang menghubungkan setiap bisnis di Indonesia dengan konektivitas yang cepat, stabil, dan aman — mendorong transformasi digital nasional.
                </p> */}
              </div>
            </SectionReveal>

            <SectionReveal direction="up" delay={0.08}>
              <div className="h-full p-6 sm:p-8 rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/50 dark:bg-white/[0.03]">
                <div className="w-10 h-10 rounded-xl flex items-center justify-center mb-5" style={{ background: 'rgba(44,56,142,0.10)', color: '#2C388E' }}>
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                    <polyline points="22 4 12 14.01 9 11.01"/>
                  </svg>
                </div>
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-1.5 h-1.5 rounded-full" style={{ background: '#2C388E' }} />
                  <span className="text-xs font-semibold tracking-[0.18em] uppercase" style={{ color: '#2C388E' }}>Misi</span>
                </div>
                <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white mb-3">
                  Layanan Tanpa Kompromi
                </h3>
                <ul className="space-y-2.5">
                  {[
                    'Deliver fast, reliable, and affordable fiber optic internet for homes and businesses.',
                    'Provide end-to-end system integration and managed IT services.',
                    'Build and expand our own network infrastructure to reach more communities.',
                    'Develop competent local talent and competitive technology',
                    'Create positive social impact through equal access to technology.',
                  ].map((item, i) => (
                    <li key={i} className="flex items-start gap-2.5 text-sm text-gray-500 dark:text-white/50">
                      <span className="mt-1.5 w-1.5 h-1.5 rounded-full shrink-0" style={{ background: '#FF6700' }} />
                      {item}
                    </li>
                  ))}
                </ul>
              </div>
            </SectionReveal>
          </div>
        </div>
      </section>

      {/* Nilai-Nilai */}
      <section className="py-14 sm:py-20 bg-[#D8E4F5] dark:bg-[#0D1117]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="mb-10 sm:mb-12">
              <div className="inline-flex items-center gap-2 mb-3">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Nilai Kami</span>
              </div>
              <h2 className="text-xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                Prinsip yang Memandu Kami
              </h2>
            </div>
          </SectionReveal>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {values.map((v, i) => (
              <SectionReveal key={v.title} direction="up" delay={i * 0.07}>
                <div className="group p-5 rounded-2xl border border-[#C0D0E8] dark:border-white/[0.06] bg-[#EEF4FF] dark:bg-white/[0.03] hover:border-[#FF6700]/40 dark:hover:border-[#FF6700]/30 hover:shadow-lg hover:shadow-[#2C388E]/8 transition-all duration-300 h-full">
                  <div
                    className="w-10 h-10 rounded-xl flex items-center justify-center mb-4 transition-all duration-300 group-hover:scale-110"
                    style={{ background: 'rgba(44,56,142,0.08)', color: '#2C388E' }}
                  >
                    {v.icon}
                  </div>
                  <h3 className="text-sm font-semibold text-gray-900 dark:text-white mb-2">{v.title}</h3>
                  <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed">{v.desc}</p>
                </div>
              </SectionReveal>
            ))}
          </div>
        </div>
      </section>

      {/* Timeline */}
      <section className="py-14 sm:py-20 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="mb-10 sm:mb-12">
              <div className="inline-flex items-center gap-2 mb-3">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Perjalanan Kami</span>
              </div>
              <h2 className="text-xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                Milestone Tekra
              </h2>
            </div>
          </SectionReveal>

          <div className="relative">
            {/* vertical line */}
            <div className="absolute left-[19px] sm:left-1/2 top-0 bottom-0 w-px" style={{ background: 'linear-gradient(to bottom, #FF6700, #2C388E)' }} />

            <div className="space-y-8">
              {milestones.map((m, i) => (
                <SectionReveal key={m.year} direction="up" delay={i * 0.08}>
                  <div className={`relative flex items-start gap-6 sm:gap-0 ${i % 2 === 0 ? 'sm:flex-row' : 'sm:flex-row-reverse'}`}>

                    {/* Content box */}
                    <div className={`pl-10 sm:pl-0 w-full sm:w-[calc(50%-28px)] ${i % 2 === 0 ? 'sm:pr-10' : 'sm:pl-10'}`}>
                      <div className="p-5 rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/60 dark:bg-white/[0.03]">
                        <span className="inline-block text-xs font-bold px-2.5 py-1 rounded-lg mb-3" style={{ background: 'rgba(255,103,0,0.12)', color: '#FF6700' }}>
                          {m.year}
                        </span>
                        <h3 className="text-sm font-semibold text-gray-900 dark:text-white mb-1.5">{m.title}</h3>
                        <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed">{m.desc}</p>
                      </div>
                    </div>

                    {/* Dot */}
                    <div className="absolute left-[11px] sm:left-1/2 sm:-translate-x-1/2 top-5 w-4 h-4 rounded-full border-2 border-white dark:border-[#080C14] z-10 shrink-0" style={{ background: i % 2 === 0 ? '#FF6700' : '#2C388E' }} />

                    {/* Spacer for opposite side */}
                    <div className="hidden sm:block sm:w-[calc(50%-28px)]" />
                  </div>
                </SectionReveal>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* CTA Bottom */}
      <section className="py-14 sm:py-20 bg-[#D8E4F5] dark:bg-[#0D1117]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="relative overflow-hidden rounded-3xl p-8 sm:p-12 text-center" style={{ background: 'linear-gradient(135deg, #2C388E, #1a2260)' }}>
              <div className="absolute inset-0 pointer-events-none">
                <div className="absolute top-0 right-0 w-64 h-64 rounded-full opacity-20" style={{ background: 'radial-gradient(circle, #FF6700, transparent 70%)', transform: 'translate(20%, -20%)' }} />
                <div className="absolute bottom-0 left-0 w-48 h-48 rounded-full opacity-15" style={{ background: 'radial-gradient(circle, #FF6700, transparent 70%)', transform: 'translate(-20%, 20%)' }} />
              </div>
              <div className="relative z-10">
                <h2 className="text-xl sm:text-3xl font-bold text-white mb-3">
                  Siap Bergabung Bersama Tekra?
                </h2>
                <p className="text-white/60 text-sm sm:text-base mb-7 max-w-md mx-auto">
                  Hubungi tim kami dan dapatkan konsultasi gratis untuk solusi jaringan terbaik bagi bisnis Anda.
                </p>
                <a
                  href="/contact"
                  className="inline-flex items-center gap-2 px-6 py-3 rounded-xl text-white font-semibold text-sm transition-all duration-200"
                  style={{ background: '#FF6700', boxShadow: '0 4px 20px rgba(255,103,0,0.40)' }}
                  onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
                  onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
                >
                  Konsultasi Sekarang
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
              </div>
            </div>
          </SectionReveal>
        </div>
      </section>

    </main>
  )
}
