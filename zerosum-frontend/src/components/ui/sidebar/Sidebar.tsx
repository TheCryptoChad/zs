import { useState } from 'react';
import { Box } from '@chakra-ui/react';
import { SidebarOpenButton } from './SidebarOpenButton';
import { ScreenBackdrop } from '../utils/ScreenBackdrop';
import { SidebarDeployBox } from './SidebarDeployBox';
import { SidebarSubmitBox } from './SidebarSubmitBox';
import { isMobile } from 'react-device-detect';
import { SidebarVesselList } from './SidebarVesselList';

export const Sidebar = () => {
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);
    const [isRegisterOpen, setIsRegisterOpen] = useState(false);
    const [deployingVesselId, setDeployingVesselId] = useState<number | null>(null);
    const [pending, setPending] = useState(false);

    const SIDEBAR_WIDTH = "350px";
    const SIDEBAR_HEIGHT_MOBILE = "200px"
    const TRANSITION = isMobile ? "bottom 0.5s ease" : "left 0.5s ease";

    const handleSidebarToggle = () => {
        setIsSidebarOpen(!isSidebarOpen);
    };

    const handleRegisterToggle = () => {
        if (pending) return;
        setIsRegisterOpen(!isRegisterOpen);
        setPending(false);
    };

    const handleDeployClose = () => {
        setDeployingVesselId(null);
    }

    const sidebarPosition = isMobile
        ? (isSidebarOpen ? '0' : `-${SIDEBAR_HEIGHT_MOBILE}`)
        : (isSidebarOpen ? '0' : `-${SIDEBAR_WIDTH}`);

    const transitionStyles = {
        position: "fixed" as const,
        transition: TRANSITION,
        zIndex: 11,
        ...(isMobile
            ? {
                bottom: sidebarPosition,
                left: "0",
                right: "0",
                width: "full",
                height: SIDEBAR_HEIGHT_MOBILE,
            }
            : {
                top: "50%",
                transform: "translateY(-50%)",
                left: sidebarPosition,
                width: SIDEBAR_WIDTH,
                height: "full",
            }
        )
    };

    return (
        <Box position="relative" display="flex" alignItems="start">
            <Box
                bg="samaBlackFade"
                color="white"
                {...transitionStyles}
                display="flex"
                flexDirection="column"
                justifyContent="space-between"
                overflowX="hidden"
                boxSizing="border-box"
            >
                <SidebarVesselList
                    setDeployingVesselId={setDeployingVesselId}
                    handleRegisterToggle={handleRegisterToggle}
                />
            </Box>
            <SidebarOpenButton isOpen={isSidebarOpen} handleToggle={handleSidebarToggle} />
            {isRegisterOpen &&
                <SidebarSubmitBox
                    handleRegisterToggle={handleRegisterToggle}
                    setPending={setPending}
                    pending={pending}
                />
            }
            {deployingVesselId !== null && (
                <ScreenBackdrop handleBackdropClick={handleDeployClose}>
                    <SidebarDeployBox vesselId={deployingVesselId} handleDeployClick={() => setDeployingVesselId(null)} />
                </ScreenBackdrop>
            )}
        </Box>
    );
}
