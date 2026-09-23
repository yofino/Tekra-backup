import SectionReveal from '../components/SectionReveal'
import { Link } from 'react-router-dom'
import NightSky from '../components/NightSky'

const specs = [
  {
    category: 'Backbone & Transit',
    color: '#2C388E',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
      </svg>
    ),
    items: [
      { label: 'Total Kapasitas', value: '100 Gbps+' },
      { label: 'Upstream Provider', value: '4 Tier-1 ISP' },
      { label: 'Autonomous System', value: 'AS Registered' },
      { label: 'Peering Point', value: 'IIX, NUSAIX, OIXP' },
    ],
  },
  {
    category: 'Jaringan Fiber',
    color: '#3D4FA8',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <line x1="12" y1="2" x2="12" y2="22"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
      </svg>
    ),
    items: [
      { label: 'Panjang Kabel', value: '2.000+ km' },
      { label: 'Teknologi', value: 'DWDM / GPON' },
      { label: 'Kecepatan Port', value: 'Up to 100G' },
      { label: 'Redundansi', value: 'Dual-path ring' },
    ],
  },
  {
    category: 'Data Center',
    color: '#FF6700',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <rect x="2" y="2" width="20" height="8" rx="2"/><rect x="2" y="14" width="20" height="8" rx="2"/>
        <line x1="6" y1="6" x2="6.01" y2="6"/><line x1="6" y1="18" x2="6.01" y2="18"/>
      </svg>
    ),
    items: [
      { label: 'Tier Level', value: 'Tier III+' },
      { label: 'Power Redundancy', value: '2N UPS + Genset' },
      { label: 'Cooling System', value: 'N+1 Precision AC' },
      { label: 'Availability', value: '99.982% uptime' },
    ],
  },
  {
    category: 'Keamanan Jaringan',
    color: '#e55c00',
    icon: (
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8">
        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/>
      </svg>
    ),
    items: [
      { label: 'DDoS Protection', value: 'Up to 1 Tbps' },
      { label: 'Firewall', value: 'Next-Gen Firewall' },
      { label: 'Monitoring', value: 'SOC 24/7' },
      { label: 'Compliance', value: 'ISO 27001' },
    ],
  },
]

const layers = [
  {
    num: '01',
    title: 'Core Layer',
    subtitle: 'Backbone Utama',
    desc: 'Backbone utama jaringan Tekra dengan kapasitas 100 Gbps menggunakan teknologi DWDM dan router core tier-1.',
    color: '#2C388E',
    items: ['Cisco ASR 9000 Series', 'DWDM 100G per channel', 'BGP full routing table', 'Redundant core links'],
  },
  {
    num: '02',
    title: 'Distribution Layer',
    subtitle: 'Agregasi & Routing',
    desc: 'Lapisan distribusi yang menghubungkan core ke edge dengan agregasi traffic dan policy routing.',
    color: '#3D4FA8',
    items: ['Aggregation switches 40G', 'OSPF/ISIS routing', 'Traffic engineering', 'QoS policy enforcement'],
  },
  {
    num: '03',
    title: 'Access Layer',
    subtitle: 'Last-Mile ke Pelanggan',
    desc: 'Titik akses terakhir menuju pelanggan menggunakan teknologi fiber optik GPON dan Metro Ethernet.',
    color: '#FF6700',
    items: ['GPON OLT 2.4 Gbps', 'Metro Ethernet 1G/10G', 'Last-mile fiber', 'CPE management'],
  },
]

const noc = [
  {
    title: 'Real-time Monitoring',
    desc: 'Seluruh node jaringan dipantau secara real-time dengan sistem alerting otomatis.',
    stat: '99.9%', statLabel: 'Uptime',
    icon: <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>,
  },
  {
    title: 'Incident Response',
    desc: 'Tim NOC merespons setiap insiden dalam waktu kurang dari 15 menit.',
    stat: '< 15m', statLabel: 'Response',
    icon: <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.41 2 2 0 0 1 3.6 1.22h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.96a16 16 0 0 0 6 6l.96-.96a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21.73 16.92z"/></svg>,
  },
  {
    title: 'Performance Analytics',
    desc: 'Laporan performa jaringan harian, mingguan, dan bulanan tersedia untuk setiap klien.',
    stat: '365', statLabel: 'Hari/Tahun',
    icon: <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>,
  },
  {
    title: 'DDoS Mitigation',
    desc: 'Sistem scrubbing center otomatis mendeteksi dan memitigasi serangan DDoS secara real-time.',
    stat: '1 Tbps', statLabel: 'Kapasitas',
    icon: <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>,
  },
]

export default function Infrastructure() {
  return (
    <main className="bg-[#EBF0FA] dark:bg-[#0D1117] min-h-screen">
      <NightSky />

      {/* ── Hero ── */}
      <section className="relative pt-[76px] pb-16 sm:pb-24 bg-[#D0D9EE] dark:bg-[#0D1117] overflow-hidden">
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-0 right-0 w-[600px] h-[600px] rounded-full opacity-[0.07]"
            style={{ background: 'radial-gradient(circle, #2C388E, transparent 65%)', transform: 'translate(25%, -25%)' }} />
          <div className="absolute bottom-0 left-0 w-[500px] h-[500px] rounded-full opacity-[0.07]"
            style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)', transform: 'translate(-25%, 25%)' }} />
          <div className="absolute inset-0 opacity-[0.03]"
            style={{ backgroundImage: 'linear-gradient(#2C388E 1px, transparent 1px), linear-gradient(90deg, #2C388E 1px, transparent 1px)', backgroundSize: '60px 60px' }} />
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 pt-12 sm:pt-20">
          <SectionReveal direction="up" delay={0}>
            <div className="inline-flex items-center gap-2 mb-5 px-3 py-1.5 rounded-full border border-[#FF6700]/25 bg-[#FF6700]/[0.07]">
              <span className="w-1.5 h-1.5 rounded-full animate-pulse" style={{ background: '#FF6700' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase" style={{ color: '#FF6700' }}>Infrastruktur</span>
            </div>
            <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black text-gray-900 dark:text-white leading-[1.1] mb-5 max-w-3xl">
              Backbone Jaringan{' '}
              <span className="text-transparent bg-clip-text" style={{ backgroundImage: 'linear-gradient(135deg, #FF6700 0%, #2C388E 100%)' }}>
                Kelas Enterprise
              </span>
            </h1>
            <p className="text-sm sm:text-base text-gray-500 dark:text-white/50 leading-relaxed max-w-xl mb-10">
              Dibangun di atas infrastruktur fiber optik sendiri dengan kapasitas 100 Gbps+, data center Tier III, dan NOC yang beroperasi 24/7.
            </p>
          </SectionReveal>

          {/* quick stats */}
          <SectionReveal direction="up" delay={0.1}>
            <div className="flex flex-wrap gap-3">
              {[
                { v: '100 Gbps+', l: 'Total Kapasitas' },
                { v: '2.000+ km', l: 'Jaringan Fiber' },
                { v: 'Tier III+', l: 'Data Center' },
                { v: 'ISO 27001', l: 'Sertifikasi' },
              ].map(s => (
                <div key={s.l} className="flex items-center gap-2.5 px-4 py-2.5 rounded-xl border border-[#C0D0E8] dark:border-white/[0.08] bg-white/60 dark:bg-white/[0.04] backdrop-blur-sm">
                  <span className="text-sm font-bold text-gray-900 dark:text-white">{s.v}</span>
                  <span className="text-[11px] text-gray-400 dark:text-white/35">{s.l}</span>
                </div>
              ))}
            </div>
          </SectionReveal>
        </div>
      </section>

      {/* ── Spesifikasi Teknis ── */}
      <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="mb-12">
              <div className="inline-flex items-center gap-2 mb-3">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Spesifikasi Teknis</span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Kapabilitas Jaringan Kami</h2>
            </div>
          </SectionReveal>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5">
            {specs.map((spec, i) => (
              <SectionReveal key={spec.category} direction="up" delay={i * 0.07}>
                <div className="group relative flex flex-col p-6 rounded-2xl border border-[#C0D0E8] dark:border-white/[0.06] bg-white/70 dark:bg-white/[0.03] h-full overflow-hidden hover:border-current transition-all duration-300"
                  style={{ '--hover-color': spec.color }}>
                  {/* top accent */}
                  <div className="absolute top-0 left-0 right-0 h-[3px] opacity-0 group-hover:opacity-100 transition-opacity duration-300"
                    style={{ background: `linear-gradient(90deg, ${spec.color}, transparent)` }} />

                  <div className="w-11 h-11 rounded-2xl flex items-center justify-center mb-5 transition-all duration-300 group-hover:scale-110"
                    style={{ background: `${spec.color}14`, color: spec.color }}>
                    {spec.icon}
                  </div>
                  <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-4">{spec.category}</h3>
                  <ul className="space-y-3 flex-1">
                    {spec.items.map((item) => (
                      <li key={item.label} className="flex items-center justify-between gap-2">
                        <span className="text-xs text-gray-500 dark:text-white/40">{item.label}</span>
                        <span className="text-xs font-bold text-right" style={{ color: spec.color }}>{item.value}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </SectionReveal>
            ))}
          </div>
        </div>
      </section>

      {/* ── Arsitektur 3 Layer ── */}
      <section className="py-16 sm:py-24 bg-[#D8E4F5] dark:bg-[#0D1117]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="mb-12">
              <div className="inline-flex items-center gap-2 mb-3">
                <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Arsitektur</span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-2">Tiga Lapisan Jaringan</h2>
              <p className="text-sm text-gray-500 dark:text-white/40 max-w-lg">
                Arsitektur hierarki tiga lapisan yang memastikan skalabilitas, keandalan, dan performa optimal.
              </p>
            </div>
          </SectionReveal>

          <div className="grid lg:grid-cols-3 gap-5">
            {layers.map((layer, i) => (
              <SectionReveal key={layer.num} direction="up" delay={i * 0.09}>
                <div className="relative flex flex-col p-6 sm:p-7 rounded-2xl border h-full overflow-hidden"
                  style={{ borderColor: `${layer.color}30`, background: `linear-gradient(160deg, ${layer.color}08, ${layer.color}03)` }}>
                  {/* bg number */}
                  <div className="absolute -bottom-4 -right-2 text-[80px] font-black leading-none select-none pointer-events-none"
                    style={{ color: `${layer.color}10` }}>{layer.num}</div>

                  <div className="flex items-center gap-3 mb-5">
                    <div className="w-10 h-10 rounded-xl flex items-center justify-center text-sm font-black text-white shrink-0"
                      style={{ background: layer.color, boxShadow: `0 4px 16px ${layer.color}40` }}>
                      {layer.num}
                    </div>
                    <div>
                      <p className="text-[10px] font-semibold uppercase tracking-wider" style={{ color: layer.color }}>{layer.subtitle}</p>
                      <h3 className="text-base font-bold text-gray-900 dark:text-white">{layer.title}</h3>
                    </div>
                  </div>

                  <p className="text-xs text-gray-500 dark:text-white/45 leading-relaxed mb-5">{layer.desc}</p>

                  <ul className="space-y-2 mt-auto">
                    {layer.items.map((item) => (
                      <li key={item} className="flex items-center gap-2.5 text-xs text-gray-600 dark:text-white/55">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke={layer.color} strokeWidth="2.5">
                          <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        {item}
                      </li>
                    ))}
                  </ul>
                </div>
              </SectionReveal>
            ))}
          </div>
        </div>
      </section>

      {/* ── NOC ── */}
      <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-6 mb-12">
              <div>
                <div className="inline-flex items-center gap-2 mb-3">
                  <span className="w-2 h-2 rounded-full" style={{ background: '#FF6700' }} />
                  <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>NOC</span>
                </div>
                <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-2">Network Operations Center</h2>
                <p className="text-sm text-gray-500 dark:text-white/40 max-w-lg">
                  Pusat kendali jaringan kami beroperasi 24 jam sehari, 7 hari seminggu, 365 hari setahun.
                </p>
              </div>
              {/* live badge */}
              <div className="flex items-center gap-2.5 px-4 py-2.5 rounded-xl border border-green-400/25 bg-green-400/[0.07] self-start lg:self-auto shrink-0">
                <span className="w-2 h-2 rounded-full bg-green-400 animate-pulse" />
                <span className="text-xs font-semibold text-green-600 dark:text-green-400">NOC Aktif Sekarang</span>
              </div>
            </div>
          </SectionReveal>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5">
            {noc.map((n, i) => (
              <SectionReveal key={n.title} direction="up" delay={i * 0.07}>
                <div className="group flex flex-col p-6 rounded-2xl border border-[#C0D0E8] dark:border-white/[0.06] bg-white/70 dark:bg-white/[0.03] h-full hover:border-[#FF6700]/35 hover:shadow-lg hover:shadow-[#FF6700]/[0.08] transition-all duration-300">
                  <div className="flex items-start justify-between mb-5">
                    <div className="w-11 h-11 rounded-2xl flex items-center justify-center transition-all duration-300 group-hover:scale-110"
                      style={{ background: 'rgba(255,103,0,0.10)', color: '#FF6700' }}>
                      {n.icon}
                    </div>
                    <div className="text-right">
                      <p className="text-lg font-black" style={{ color: '#FF6700' }}>{n.stat}</p>
                      <p className="text-[10px] text-gray-400 dark:text-white/30 font-medium">{n.statLabel}</p>
                    </div>
                  </div>
                  <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-2">{n.title}</h3>
                  <p className="text-xs text-gray-500 dark:text-white/40 leading-relaxed">{n.desc}</p>
                </div>
              </SectionReveal>
            ))}
          </div>
        </div>
      </section>

      {/* ── CTA ── */}
      <section className="py-16 sm:py-24 bg-[#D8E4F5] dark:bg-[#0D1117]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6">
          <SectionReveal direction="up" delay={0}>
            <div className="relative overflow-hidden rounded-3xl" style={{ background: 'linear-gradient(135deg, #1a2260 0%, #2C388E 50%, #1a2260 100%)' }}>
              <div className="absolute inset-0 pointer-events-none">
                <div className="absolute -top-20 -right-20 w-80 h-80 rounded-full opacity-20"
                  style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)' }} />
                <div className="absolute -bottom-16 -left-16 w-64 h-64 rounded-full opacity-15"
                  style={{ background: 'radial-gradient(circle, #FF6700, transparent 65%)' }} />
                <div className="absolute inset-0 opacity-[0.04]"
                  style={{ backgroundImage: 'linear-gradient(white 1px, transparent 1px), linear-gradient(90deg, white 1px, transparent 1px)', backgroundSize: '40px 40px' }} />
              </div>

              <div className="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-8 p-8 sm:p-12">
                <div className="text-center lg:text-left">
                  <p className="text-[11px] font-semibold tracking-[0.2em] uppercase mb-3" style={{ color: '#FF6700' }}>Terhubung Sekarang</p>
                  <h2 className="text-2xl sm:text-3xl font-black text-white mb-3">Ingin Terhubung ke Jaringan Kami?</h2>
                  <p className="text-white/55 text-sm max-w-md">
                    Hubungi tim teknis kami untuk mendiskusikan kebutuhan konektivitas dan solusi terbaik untuk bisnis Anda.
                  </p>
                </div>
                <div className="flex flex-col sm:flex-row gap-3 shrink-0">
                  <Link to="/contact"
                    className="inline-flex items-center justify-center gap-2 px-7 py-3.5 rounded-xl text-white font-bold text-sm transition-all duration-200"
                    style={{ background: '#FF6700', boxShadow: '0 4px 24px rgba(255,103,0,0.45)' }}
                    onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
                    onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
                  >
                    Hubungi Tim Teknis
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                  </Link>
                  <Link to="/services"
                    className="inline-flex items-center justify-center gap-2 px-7 py-3.5 rounded-xl font-bold text-sm border border-white/20 text-white/80 hover:bg-white/10 transition-all duration-200"
                  >
                    Lihat Layanan
                  </Link>
                </div>
              </div>
            </div>
          </SectionReveal>
        </div>
      </section>

    </main>
  )
}
