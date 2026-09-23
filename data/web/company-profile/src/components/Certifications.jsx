import SectionReveal from './SectionReveal'

const certifications = [
  { code: 'KOMINFO', label: 'Terdaftar Resmi' },
  { code: 'APJII', label: 'Anggota Resmi' },
  { code: 'IDNIC', label: 'Internet Registry' },
  { code: 'AS Number', label: 'Autonomous System' },
  { code: 'IPv4 / IPv6', label: 'IP Address Block' },
  { code: 'NIB Resmi', label: '1509260053269' },
]

const items = [...certifications, ...certifications]

export default function Certifications() {
  return (
    <section
      className="py-6 sm:py-8 bg-[#C8D8EE] dark:bg-[#0D1117] border-y border-[#B0C4E0] dark:border-white/[0.06]"
      style={{ overflow: 'clip' }}
    >
      <SectionReveal direction="up" delay={0.1}>
        <div className="max-w-7xl mx-auto px-4 sm:px-6 mb-4 sm:mb-6">
          <div className="flex items-center gap-2">
            <span className="w-2 h-2 rounded-full shrink-0" style={{ background: '#FF6700' }} />
            <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#2C388E' }}>
              Sertifikasi &amp; Legalitas Resmi Tekra
            </span>
          </div>
        </div>
      </SectionReveal>

      <div className="relative">
        <div className="absolute left-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to right, #C8D8EE, transparent)' }} />
        <div className="absolute right-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to left, #C8D8EE, transparent)' }} />
        <div className="dark:hidden absolute left-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to right, #C8D8EE, transparent)' }} />
        <div className="dark:hidden absolute right-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to left, #C8D8EE, transparent)' }} />
        <div className="hidden dark:block absolute left-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to right, #0D1117, transparent)' }} />
        <div className="hidden dark:block absolute right-0 top-0 bottom-0 w-12 z-10 pointer-events-none" style={{ background: 'linear-gradient(to left, #0D1117, transparent)' }} />

        <div className="flex gap-3 w-max animate-marquee">
          {items.map((c, i) => (
            <div
              key={i}
              className="flex items-center gap-2 px-3 py-2 rounded-xl border shrink-0 bg-white/50 dark:bg-white/[0.03] border-[#2C388E]/15 dark:border-white/10"
            >
              <span className="w-1.5 h-1.5 rounded-full shrink-0" style={{ background: '#FF6700' }} />
              <span className="text-sm font-semibold whitespace-nowrap text-[#1a2060] dark:text-white/80">{c.code}</span>
              <span className="text-xs whitespace-nowrap text-gray-400 dark:text-white/30">{c.label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
