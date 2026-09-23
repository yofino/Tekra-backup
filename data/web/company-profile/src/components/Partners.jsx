import SectionReveal from './SectionReveal'
import { useTheme } from '../context/ThemeContext'

const isp = [
  { name: 'LintasArta',       logo: '/images/partners/lintasarta-2024-seeklogo.png' },
  { name: 'Telkom Indonesia', logo: '/images/partners/telkom-indonesia-seeklogo.png' },
  { name: 'Iforte',           logo: '/images/partners/iforte-seeklogo.png' },
  { name: 'Fiberstar',        logo: '/images/partners/fiberstar.png' },
  { name: 'CBN',              logo: '/images/partners/CBN.png'},
  { name: 'Cloudflare',       logo: '/images/partners/Cloudflare.png'},
  { name: 'CGS(Cendikia Global Solusi',     logo:'/images/partners/CGS.png'},
]

const si = [
  { name: 'Hikvision',     logo: '/images/partners-integerator/hikvision.png' },
  { name: 'Dahua',         logo: '/images/partners-integerator/dahua.png' },
  { name: 'Vivotek',       logo: '/images/partners-integerator/vivotek.png' },
  { name: 'Hanwha Vision', logo: '/images/partners-integerator/hanwha.png' },
  { name:'Genetec',        logo:'/images/partners-integerator/genetec.png'},
  { name:'Ruijie',         logo:'/images/partners-integerator/ruijie.png'},
  { name:'Mikrotik',       logo:'/images/partners-integerator/mikrotik.png'},
  { name:'Axis Camera',    logo:'/images/partners-integerator/axisCamera.png'},
]

const clients = [
  { name: 'Bank BJB',      logo: '/images/clients/bank-bjb.png' },
  { name: 'BPJS',          logo: '/images/clients/BPJS.png' },
  { name: 'Helios',        logo: '/images/clients/helios-removebg-preview.png' },
  { name: 'Padma Bandung', logo: '/images/clients/padma-bandung-logo.png' },
  { name: 'Pengadilan',    logo: '/images/clients/pengadilan.png' },
  { name: 'Summarecon',    logo: '/images/clients/sumarecon.png' },
  { name: 'Miniapolis',    logo:'/images/clients/miniapolis.png'},
  { name: 'Kota Baru Parahyangan',  logo: '/images/clients/KBP.png'},
]

function LogoCard({ name, logo, white }) {
  return (
    <div className={`flex items-center justify-center px-6 py-4 rounded-2xl border transition-all duration-300 h-20 hover:shadow-md ${
      white
        ? 'border-gray-200 dark:border-white/[0.10] bg-white dark:bg-white/[0.08] hover:border-[#2C388E]/40 dark:hover:border-[#7B8FE8]/30'
        : 'border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] hover:border-[#2C388E]/40 dark:hover:border-[#7B8FE8]/30'
    }`}>
      <img
        src={logo}
        alt={name}
        className="max-h-10 max-w-[120px] w-auto object-contain transition-all duration-300 opacity-90"
        onError={e => {
          e.currentTarget.style.display = 'none'
          e.currentTarget.nextSibling.style.display = 'block'
        }}
      />
      <span className="hidden text-xs font-semibold text-gray-500 dark:text-white/40">{name}</span>
    </div>
  )
}

export default function Partners() {
  const { dark } = useTheme()
  const fadeColor = dark ? '#080C14' : '#EBF0FA'

  return (
    <section className="py-16 sm:py-24 bg-[#EBF0FA] dark:bg-[#080C14]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6">

        {/* ISP Partners */}
        <SectionReveal direction="up" delay={0}>
          <div className="text-center mb-10">
            <div className="inline-flex items-center gap-2 mb-3 px-3 py-1.5 rounded-full border border-[#2C388E]/20 bg-[#2C388E]/[0.06]">
              <span className="w-1.5 h-1.5 rounded-full" style={{ background: '#2C388E' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase text-[#2C388E] dark:text-[#7B8FE8]">Network Partners</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Mitra ISP & Carrier</h2>
            <p className="text-sm text-gray-500 dark:text-white/40 mt-2">Didukung oleh operator jaringan terpercaya di Indonesia</p>
          </div>
          <div className="relative overflow-hidden">
            <div className="absolute left-0 top-0 bottom-0 w-16 z-10 pointer-events-none" style={{ background: `linear-gradient(to right, ${fadeColor}, transparent)` }} />
            <div className="absolute right-0 top-0 bottom-0 w-16 z-10 pointer-events-none" style={{ background: `linear-gradient(to left, ${fadeColor}, transparent)` }} />
            <div className="flex animate-marquee gap-6 w-max">
              {[...isp, ...isp].map((p, i) => (
                <div key={i} className="flex items-center justify-center px-6 py-4 rounded-2xl border border-gray-200 dark:border-white/[0.10] bg-white dark:bg-white/[0.08] h-20 w-40 shrink-0">
                  <img src={p.logo} alt={p.name} className="max-h-10 max-w-[110px] w-auto object-contain opacity-90" onError={e => { e.currentTarget.style.display='none'; e.currentTarget.nextSibling.style.display='block' }} />
                  <span className="hidden text-xs font-semibold text-gray-500 dark:text-white/40">{p.name}</span>
                </div>
              ))}
            </div>
          </div>
        </SectionReveal>

        {/* Divider SI */}
        <SectionReveal direction="up" delay={0.05}>
          <div className="flex items-center gap-4 mb-16">
            <div className="flex-1 h-px bg-[#C8D4EC] dark:bg-white/[0.07]" />
            <span className="text-[11px] font-semibold tracking-[0.2em] uppercase text-gray-400 dark:text-white/30">System Integrator</span>
            <div className="flex-1 h-px bg-[#C8D4EC] dark:bg-white/[0.07]" />
          </div>
        </SectionReveal>

        {/* SI Partners */}
        <SectionReveal direction="up" delay={0.1}>
          <div className="text-center mb-10">
            <div className="inline-flex items-center gap-2 mb-3 px-3 py-1.5 rounded-full border border-[#FF6700]/20 bg-[#FF6700]/[0.06]">
              <span className="w-1.5 h-1.5 rounded-full" style={{ background: '#FF6700' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase" style={{ color: '#FF6700' }}>System Integrator Partners</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Mitra Teknologi</h2>
            <p className="text-sm text-gray-500 dark:text-white/40 mt-2">Solusi keamanan & surveillance dari brand global terkemuka</p>
          </div>
          <div className="relative overflow-hidden">
            <div className="absolute left-0 top-0 bottom-0 w-16 z-10 pointer-events-none" style={{ background: `linear-gradient(to right, ${fadeColor}, transparent)` }} />
            <div className="absolute right-0 top-0 bottom-0 w-16 z-10 pointer-events-none" style={{ background: `linear-gradient(to left, ${fadeColor}, transparent)` }} />
            <div className="flex animate-marquee-reverse gap-6 w-max">
              {[...si, ...si].map((p, i) => (
                <div key={i} className="flex items-center justify-center px-6 py-4 rounded-2xl border border-[#C8D4EC] dark:border-white/[0.07] bg-white/70 dark:bg-white/[0.03] h-20 w-40 shrink-0">
                  <img src={p.logo} alt={p.name} className="max-h-10 max-w-[110px] w-auto object-contain opacity-90" onError={e => { e.currentTarget.style.display='none'; e.currentTarget.nextSibling.style.display='block' }} />
                  <span className="hidden text-xs font-semibold text-gray-500 dark:text-white/40">{p.name}</span>
                </div>
              ))}
            </div>
          </div>
        </SectionReveal>

        {/* Divider Clients */}
        <SectionReveal direction="up" delay={0.05}>
          <div className="flex items-center gap-4 mt-16 mb-16">
            <div className="flex-1 h-px bg-[#C8D4EC] dark:bg-white/[0.07]" />
            <span className="text-[11px] font-semibold tracking-[0.2em] uppercase text-gray-400 dark:text-white/30">Clients</span>
            <div className="flex-1 h-px bg-[#C8D4EC] dark:bg-white/[0.07]" />
          </div>
        </SectionReveal>

        {/* Clients Marquee */}
        <SectionReveal direction="up" delay={0.1}>
          <div className="text-center mb-8">
            <div className="inline-flex items-center gap-2 mb-3 px-3 py-1.5 rounded-full border border-[#2C388E]/20 bg-[#2C388E]/[0.06]">
              <span className="w-1.5 h-1.5 rounded-full" style={{ background: '#2C388E' }} />
              <span className="text-[11px] font-semibold tracking-[0.18em] uppercase text-[#2C388E] dark:text-[#7B8FE8]">Trusted By</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">Klien Kami</h2>
            <p className="text-sm text-gray-500 dark:text-white/40 mt-2">Dipercaya oleh berbagai institusi dan perusahaan terkemuka</p>
          </div>

          <div className="relative overflow-hidden">
            <div className="absolute left-0 top-0 bottom-0 w-16 z-10 pointer-events-none"
              style={{ background: `linear-gradient(to right, ${fadeColor}, transparent)` }} />
            <div className="absolute right-0 top-0 bottom-0 w-16 z-10 pointer-events-none"
              style={{ background: `linear-gradient(to left, ${fadeColor}, transparent)` }} />

            <div className="flex animate-marquee gap-6 w-max">
              {[...clients, ...clients].map((c, i) => (
                <div key={i} className="flex items-center justify-center px-6 py-4 rounded-2xl border border-gray-200 dark:border-white/[0.10] bg-white dark:bg-white/[0.06] h-20 w-40 shrink-0">
                  <img
                    src={c.logo}
                    alt={c.name}
                    className="max-h-10 max-w-[110px] w-auto object-contain opacity-90 transition-all duration-300"
                  />
                </div>
              ))}
            </div>
          </div>
        </SectionReveal>

      </div>
    </section>
  )
}