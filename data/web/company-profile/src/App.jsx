import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom'
import { AnimatePresence } from 'framer-motion'
import { ThemeProvider } from './context/ThemeContext'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import PageLoader from './components/PageLoader'
import PageTransition from './components/PageTransition'
import Home from './pages/Home'
import About from './pages/About'
import ServicesPage from './pages/Services'
import Pricing from './pages/Pricing'
import Contact from './pages/Contact'
import Infrastructure from './pages/Infrastructure'

function AnimatedRoutes() {
  const location = useLocation()

  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/"              element={<PageTransition><Home /></PageTransition>} />
        <Route path="/about"         element={<PageTransition><About /></PageTransition>} />
        <Route path="/services"      element={<PageTransition><ServicesPage /></PageTransition>} />
        <Route path="/infrastructure" element={<PageTransition><Infrastructure /></PageTransition>} />
        <Route path="/pricing"       element={<PageTransition><Pricing /></PageTransition>} />
        <Route path="/contact"       element={<PageTransition><Contact /></PageTransition>} />
      </Routes>
    </AnimatePresence>
  )
}

export default function App() {
  return (
    <ThemeProvider>
      <BrowserRouter>
        <div className="w-full bg-[#EBF0FA] dark:bg-[#0D1117]">
          <PageLoader />
          <Navbar />
          <AnimatedRoutes />
          <Footer />
        </div>
      </BrowserRouter>
    </ThemeProvider>
  )
}
