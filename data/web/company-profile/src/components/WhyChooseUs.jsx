import { useEffect, useRef, useState } from 'react'
import { Link } from 'react-router-dom'

const features = [
  {
    num: '01', title: 'Reliable Network',
    desc: 'Jaringan yang stabil dengan infrastruktur yang dirancang untuk menjaga konektivitas bisnis tetap tersedia.',
    icon: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><path d="M1.5 8.5C5.5 4.5 18.5 4.5 22.5 8.5"/><path d="M5 12c2-2 12-2 14 0"/><path d="M8.5 15.5c1-1 6-1 7 0"/><circle cx="12" cy="19" r="1" fill="currentColor"/></svg>,
  },
  {
    num: '02', title: '24/7 Monitoring',
    desc: 'Network Operation Center memantau jaringan secara aktif untuk menjaga performa dan mendeteksi gangguan lebih cepat.',
    icon: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>,
  },
  {
    num: '03', title: 'Scalable Infrastructure',
    desc: 'Infrastruktur fleksibel yang dapat berkembang mengikuti kebutuhan konektivitas dan pertumbuhan bisnis.',
    icon: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8"><rect x="2" y="3" width="20" height="4" rx="1"/><rect x="2" y="10" width="20" height="4" rx="1"/><rect x="2" y="17" width="20" height="4" rx="1"/></svg>,
  },
]

const FeatureItem = ({ f }) => {
  const [hovered, setHovered] = useState(false)
  return (
    <div
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      className="relative flex items-start gap-3 px-3 py-5 sm:px-4 sm:py-4 bg-[#EBF0FA]/60 dark:bg-[#0D1117]/60 transition-colors duration-200 overflow-hidden cursor-default"
      style={{
        boxShadow: hovered ? 'inset 0 0 0 1px rgba(44,56,142,0.30), inset 0 0 24px rgba(44,56,142,0.06)' : 'inset 0 0 0 1px transparent',
        transition: 'box-shadow 0.3s ease',
      }}
    >
      <div
        className="absolute top-0 left-0 right-0 h-px"
        style={{
          background: hovered ? 'linear-gradient(90deg, transparent, rgba(255,103,0,0.55), transparent)' : 'transparent',
          transition: 'background 0.3s ease',
        }}
      />
      <div
        className="shrink-0 w-9 h-9 rounded-xl flex items-center justify-center transition-all duration-300"
        style={hovered
          ? { background: 'rgba(255,103,0,0.15)', color: '#FF6700', boxShadow: '0 4px 12px rgba(255,103,0,0.20)' }
          : { background: 'rgba(44,56,142,0.08)', color: '#2C388E' }
        }
      >
        {f.icon}
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 mb-1">
          <span className="text-[10px] font-bold tracking-widest" style={{ color: 'rgba(44,56,142,0.45)' }}>{f.num}</span>
          <span
            className="text-sm font-semibold transition-colors duration-200 dark:text-white"
            style={{ color: hovered ? '#FF6700' : undefined }}
          >{f.title}</span>
        </div>
        <p className="text-gray-500 dark:text-white/40 text-xs leading-relaxed">{f.desc}</p>
      </div>
    </div>
  )
}

export default function WhyChooseUs() {
  const sectionRef = useRef(null)
  const [visible, setVisible] = useState(false)
  const [lottieScale, setLottieScale] = useState(0.4)
  const [lottieOpacity, setLottieOpacity] = useState(0)
  const triggered = useRef(false)

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting && !triggered.current) {
          triggered.current = true
          setLottieOpacity(1)
          setVisible(true)
          const start = performance.now()
          const duration = 1000
          const animate = (now) => {
            const t = Math.min((now - start) / duration, 1)
            setLottieScale(0.4 + t * 0.6)
            if (t < 1) requestAnimationFrame(animate)
          }
          requestAnimationFrame(animate)
        }
      },
      { threshold: 0.15 }
    )
    if (sectionRef.current) observer.observe(sectionRef.current)
    return () => observer.disconnect()
  }, [])

  return (
    <section ref={sectionRef} className="relative py-12 sm:py-16 md:py-20 min-h-screen sm:min-h-0 flex flex-col justify-center sm:block bg-[#EBF0FA] dark:bg-[#0D1117] overflow-x-hidden">

      <div
        className="hidden lg:flex absolute inset-0 pointer-events-none items-center justify-center"
        style={{ opacity: lottieOpacity * 0.15, transform: `scale(${lottieScale})`, transition: 'opacity 0.5s ease' }}
      >
        <iframe src="https://lottie.host/embed/9738897e-4ab1-4799-aded-81ce1032dd28/Ve6ofO6naN.json" className="border-none w-full h-full" />
      </div>
      

      <div className="relative z-10 w-full max-w-7xl mx-auto px-4 sm:px-6" style={{ perspective: '1200px' }}>
        <div
          style={{
            transition: 'transform 0.85s cubic-bezier(0.22, 1, 0.36, 1), opacity 0.85s ease',
            transform: visible ? 'rotateX(0deg) translateY(0px)' : 'rotateX(40deg) translateY(60px)',
            opacity: visible ? 1 : 0,
            transformOrigin: 'center bottom',
          }}
        >
          <div className="grid lg:grid-cols-2 gap-10 sm:gap-8 lg:gap-14 items-start">

          {/* Left */}
          <div className="relative">
            <div className="lg:hidden absolute inset-0 -z-10 pointer-events-none overflow-visible">
              <div
                className="w-full h-full flex items-center justify-center"
                style={{ opacity: lottieOpacity * 0.15, transform: `scale(${lottieScale}) translateY(100px)`, transition: 'opacity 0.5s ease' }}
              >
                <iframe src="https://lottie.host/embed/9738897e-4ab1-4799-aded-81ce1032dd28/Ve6ofO6naN.json" className="border-none w-[300%] h-[300%]" />
              </div>
            </div>

            <div className="relative z-10">
              <div className="inline-flex items-center gap-2 mb-6">
                <span className="w-2 h-2 rounded-full shrink-0" style={{ background: '#FF6700' }} />
                <span className="text-xs font-semibold tracking-[0.2em] uppercase" style={{ color: '#FF6700' }}>Why Choose Us</span>
              </div>
              <h2 className="text-xl sm:text-2xl lg:text-3xl font-bold text-gray-900 dark:text-white leading-tight mb-4 sm:mb-3">
                Built for Reliable <br />Connectivity
              </h2>
              <p className="text-gray-500 dark:text-white/50 text-xs sm:text-sm leading-relaxed mb-6">
                Infrastruktur jaringan yang dirancang untuk memberikan konektivitas yang stabil, aman, dan siap mendukung pertumbuhan bisnis Anda.
              </p>
              <Link
                to="/about"
                className="inline-flex items-center gap-2 font-semibold text-sm hover:gap-3 transition-all duration-200"
                style={{ color: '#2C388E' }}
              >
                Pelajari Lebih Lanjut
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
              </Link>
            </div>
          </div>

          {/* Right */}
          <div>
            <div className="flex flex-col gap-px bg-[#C8D4EC]/60 dark:bg-white/5 rounded-2xl overflow-hidden">
              {features.map((f) => (
                <FeatureItem key={f.num} f={f} />
              ))}
            </div>
          </div>

          </div>
        </div>
      </div>
    </section>
  )
}
