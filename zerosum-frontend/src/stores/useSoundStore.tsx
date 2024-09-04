import { create } from "zustand";

export const useSoundStore = create<Zustand.SoundState>((set) => ({
    sound: true,
    toggleSound: () => set((state) => ({ sound: !state.sound })),
}));