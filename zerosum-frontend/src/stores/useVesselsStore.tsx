import { create } from "zustand";

export const useVesselsStore = create<Zustand.VesselState>((set) => ({
    selectedVessel: null,
    selectVessel: (vessel: Vessel) => set(() => ({
        selectedVessel: vessel
    })),
    clearSelectedVessel: () => { set(() => ({ selectedVessel: null })) },
    vessels: new Map<number, Vessel>(),
    addVessel: (vessel: Vessel) => {
        set((state) => ({
            vessels: new Map(state.vessels).set(vessel.id, vessel),
        }));
    },
}));
