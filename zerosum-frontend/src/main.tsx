import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import { ChakraProvider } from '@chakra-ui/react'
import { chains, config } from "./utils/config.ts"
import { RainbowKitProvider } from '@rainbow-me/rainbowkit'
import { WagmiConfig } from 'wagmi'
import { QueryClient, QueryClientProvider } from 'react-query'

import '@rainbow-me/rainbowkit/styles.css';
import '@fontsource/raleway/400.css'
import "@fontsource/orbitron/400.css"

import './index.css'

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false
    }
  }
})

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <QueryClientProvider client={queryClient}>
    <WagmiConfig config={config.wagmi}>
      <RainbowKitProvider theme={config.rainbowKit} chains={chains}>
        <ChakraProvider theme={config.chakra}>
          <App />
        </ChakraProvider>
      </RainbowKitProvider>
    </WagmiConfig>
  </QueryClientProvider>
)
