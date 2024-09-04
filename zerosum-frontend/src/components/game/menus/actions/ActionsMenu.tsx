import { Html } from "@react-three/drei";
import React from "react";
import "./actionsMenu.css"
import { Group, Vector3 } from "three";

interface ActionsMenuProps {
    actionMenuButtonProps: Props.ActionsMenuButton[];
    shouldDisplay: boolean;
    position: number[]
}

export const ActionsMenu = React.forwardRef<Group, ActionsMenuProps>(
    ({ actionMenuButtonProps, shouldDisplay, position }, ref) => {
        return shouldDisplay && (
            <group ref={ref} position={new Vector3(position[0], position[1], position[2])}>
                <Html
                    zIndexRange={[1, 0]}
                    center
                    wrapperClass="parent"
                    pointerEvents="none"
                >
                    <div className="actionsBox">
                        {actionMenuButtonProps.map((button: Props.ActionsMenuButton) => (
                            <button
                                disabled={button.disabled}
                                key={button.text}
                                className={button.disabled ? "actionButtonDisabled" : "actionButton"}
                                onPointerMove={(event) => {
                                    event.stopPropagation()
                                }}
                                onClick={(event) => {
                                    event.stopPropagation();
                                    button.effect();
                                }}
                            >
                                <div className={button.disabled ? "actionButtonContentDisabled" : "actionButtonContent"}>{button.text}</div>
                            </button>
                        ))}
                    </div>
                </Html>
            </group>
        )
    }
);

export default ActionsMenu;
