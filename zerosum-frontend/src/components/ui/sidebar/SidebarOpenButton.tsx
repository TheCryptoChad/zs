import { Button, Image } from '@chakra-ui/react';
import DoubleArrowLeftIcon from "../../../assets/icons/double_arrow_left_icon.svg"
import DoubleArrowRightIcon from "../../../assets/icons/double_arrow_right_icon.svg"
import DoubleArrowUpIcon from "../../../assets/icons/double_arrow_up_icon.svg"
import DoubleArrowDownIcon from "../../../assets/icons/double_arrow_down_icon.svg"
import { isMobile } from 'react-device-detect';

interface SidebarOpenButtonProps {
    isOpen: boolean,
    handleToggle: () => void
}

export const SidebarOpenButton = ({ isOpen, handleToggle }: SidebarOpenButtonProps) => {
    const SIDEBAR_WIDTH = "350px";
    const SIDEBAR_HEIGHT_MOBILE = "200px"

    const buttonPosition = isMobile
        ? (isOpen ? SIDEBAR_HEIGHT_MOBILE : '0')
        : (isOpen ? SIDEBAR_WIDTH : '0');

    const transitionStyles = isMobile
        ? {
            position: "fixed" as const,
            transition: "bottom 0.5s ease, background-color 0.3s",
            bottom: buttonPosition,
            left: '0',
            right: '0',
            marginLeft: 'auto',
            marginRight: 'auto',
            zIndex: 11,
            w: 16,
            borderTopRadius: 10,
            borderBottomRadius: 0
        }
        : {
            position: "fixed" as const,
            transition: "left 0.5s ease, background-color 0.3s",
            top: "50%",
            transform: "translateY(-50%)",
            left: buttonPosition,
            zIndex: 11,
            px: 0,
            py: 8,
            borderRightRadius: 10,
            borderLeftRadius: 0
        };

    return (
        <Button
            onClick={handleToggle}
            {...transitionStyles}
            bg={"samaBlackFade"}
            _active={{
                background: isMobile && "samaTeal.500"
            }}
            _hover={{
                background: !isMobile && "samaTeal.500",
            }}
        >
            <Image
                h={"32px"}
                w={"32px"}
                p={0}
                src={
                    isOpen
                        ? isMobile ? DoubleArrowDownIcon : DoubleArrowLeftIcon
                        : isMobile ? DoubleArrowUpIcon : DoubleArrowRightIcon
                }
            />
        </Button>
    );
};
