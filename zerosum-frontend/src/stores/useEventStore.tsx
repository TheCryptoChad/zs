import { create } from "zustand";

export const useEventStore = create<Zustand.EventState>((set) => ({
    event: null,
    send: (event: Zustand.Event) => {
        set({ event: event })
    },
    clear: () => set({ event: null }),
}));
