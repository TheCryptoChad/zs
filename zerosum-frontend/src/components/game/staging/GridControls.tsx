import { useThree } from "@react-three/fiber";
import { useState, useCallback, useEffect } from "react";
import { Vector2 } from "three";

export const Grid3DControls = () => {
    const { camera, gl } = useThree();

    const [prevMousePosition, setPrevMousePosition] = useState<Vector2 | null>(null);

    const handleStart = useCallback((event: PointerEvent | TouchEvent) => {
        let x, y;

        if (event instanceof TouchEvent) {
            x = event.touches[0].clientX;
            y = event.touches[0].clientY;
        } else {
            x = event.clientX;
            y = event.clientY;
        }

        setPrevMousePosition(new Vector2(x, y));
    }, []);

    const handleMove = useCallback((event: PointerEvent | TouchEvent) => {
        let x, y;

        if (event instanceof TouchEvent) {
            x = event.touches[0].clientX;
            y = event.touches[0].clientY;
        } else {
            x = event.clientX;
            y = event.clientY;
        }

        const currentMousePosition = new Vector2(x, y);

        if (event instanceof TouchEvent || (event as PointerEvent).buttons === 1) {
            if (prevMousePosition) {
                const delta = new Vector2()
                    .subVectors(currentMousePosition, prevMousePosition)
                    .divideScalar(50);

                const newX = camera.position.x + delta.x;
                const newZ = camera.position.z + delta.y;

                if (newX > 0 && newX < 100) {
                    camera.position.x = newX;
                }
                if (newZ > -2.5 && newZ < 97.5) {
                    camera.position.z = newZ;
                }
            }
            setPrevMousePosition(currentMousePosition);
        } else {
            setPrevMousePosition(null);
        }
    }, [prevMousePosition, camera.position]);

    useEffect(() => {
        const canvas = gl.domElement;
        canvas.addEventListener('pointerdown', handleStart);
        canvas.addEventListener('touchstart', handleStart, { passive: false });
        canvas.addEventListener('pointermove', handleMove);
        canvas.addEventListener('touchmove', handleMove, { passive: false });

        return () => {
            canvas.removeEventListener('pointerdown', handleStart);
            canvas.removeEventListener('touchstart', handleStart);
            canvas.removeEventListener('pointermove', handleMove);
            canvas.removeEventListener('touchmove', handleMove);
        };
    }, [handleStart, handleMove, gl.domElement]);

    return null;
}
