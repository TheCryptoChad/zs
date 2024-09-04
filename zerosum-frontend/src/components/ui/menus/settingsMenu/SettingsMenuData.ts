export const SettingsMenuData = {
  main: [
    {
      label: "Tutorial",
      onClick: () => window.open("https://docs.google.com/document/d/1NIXu3g1t6MGTFp8vqmGV7GPlKksbCk5k0lQGgqyfC6g/edit?usp=sharing", "_blank"),
      disabled: false,
    },
    {
      label: "Manta Testnet",
      onClick: () => window.open("https://manta-testnet.calderaexplorer.xyz/"),
      disabled: false,
    },
    {
      label: "Base Mainnet Bridge",
      onClick: () => window.open("https://bridge.base.org/deposit"),
      disabled: false,
    },
    {
      label: "Settings",
      onClick: () => null,
      disabled: true,
    },
  ],
  socials: [
    {
      label: "Raresama",
      onClick: () => window.open("https://raresama.com/"),
      disabled: false,
    },
    {
      label: "ZeroSum Telegram",
      onClick: () => window.open("https://t.me/zerosumengine", "_blank"),
      disabled: false,
    },
    {
      label: "Moonsama Twitter",
      onClick: () => window.open("https://twitter.com/moonsamanft", "_blank"),
      disabled: false,
    },
    {
      label: "Moonsama Telegram",
      onClick: () => window.open("https://t.me/MoonsamaNFT"),
      disabled: false,
    },
    {
      label: "Moonsama Discord",
      onClick: () => window.open("https://discord.gg/moonsama", "_blank"),
      disabled: false,
    },
  ],
};
