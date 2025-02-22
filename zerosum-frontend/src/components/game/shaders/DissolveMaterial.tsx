import * as THREE from 'three'
import * as React from 'react'
import CSM from 'three-custom-shader-material'
import { patchShaders } from 'gl-noise'
import { useFrame } from '@react-three/fiber'

const vertexShader = /* glsl */ `
  varying vec2 custom_vUv;
  varying vec3 custom_vPosition;
  varying vec3 custom_vBoxUv;
  uniform vec3 uBoxMin;
  uniform vec3 uBoxMax;
  void main() {
    custom_vUv = uv;
    custom_vPosition = position;
    custom_vBoxUv = (position - uBoxMin) / (uBoxMax - uBoxMin);
  }`

const fragmentShader = patchShaders(/* glsl */ `
  varying vec2 custom_vUv;
  varying vec3 custom_vPosition;
  varying vec3 custom_vBoxUv;
  uniform mat4 uMatrix;
  uniform float uFeather;
  uniform float uThickness;
  uniform sampler2D uRamp;
  uniform vec3 uColor;   
  float sdfBox(vec3 p, vec3 b) {
    vec3 q = abs(p) - b;
    return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
  }
  vec3 transform(vec3 p) {
    return (inverse(uMatrix) * vec4(p, 1.0)).xyz;
  }
  void main() {
    gln_tFBMOpts opts = gln_tFBMOpts(1.0, 0.3, 2.0, 5.0, 1.0, 5, false, false);
    float noise = gln_sfbm(custom_vPosition, opts);
    noise = gln_normalize(noise);
    vec3 transformed = transform(custom_vPosition);
    float distance = smoothstep(0.0, uFeather, sdfBox(transformed, vec3(0.75)));
    float progress = distance;
    float alpha = step(1.0 - progress, noise);
    float border = step((1.0 - progress) - uThickness, noise) - alpha;
    csm_DiffuseColor.a = alpha + border;
    csm_DiffuseColor.rgb = mix(csm_DiffuseColor.rgb, uColor, border);
  }`)

const o = new THREE.Object3D()
o.position.set(-2, -3, 0)
o.scale.setScalar(3)
o.updateMatrixWorld()

const uniforms = {
  uMatrix: { value: o.matrixWorld },
  uFeather: { value: 6 },
  uThickness: { value: 0.1 },
  uColor: { value: new THREE.Color('#eb5a13').multiplyScalar(20) },
}

export const DissolveMaterial = ({ baseMaterial, thickness = 0.1, feather = 6, color = '#eb5a13', intensity = 50 }: { baseMaterial: THREE.Material, thickness: number, feather: number, color: string, intensity: number }) => {
  const [startAnimating, setStartAnimating] = React.useState(false);

  React.useEffect(() => {
    o.position.set(-2, -3, 0);
    o.updateMatrixWorld();
    uniforms.uMatrix.value = o.matrixWorld;

    const timer = setTimeout(() => {
      setStartAnimating(true);
    }, 2000); // Wait for 2 seconds

    return () => clearTimeout(timer); // Clear the timer if the component unmounts
  }, []);

  useFrame(() => {
    if (startAnimating) {
      o.position.y += 0.02; // Adjust the speed of upward motion here
      o.updateMatrixWorld();
      uniforms.uMatrix.value = o.matrixWorld;
    }
  })

  React.useEffect(() => {
    uniforms.uFeather.value = feather
    uniforms.uThickness.value = thickness
    uniforms.uColor.value.set(color).multiplyScalar(intensity)
  }, [feather, thickness, color, intensity])

  return (
    <>
      <CSM baseMaterial={baseMaterial} vertexShader={vertexShader} fragmentShader={(fragmentShader as string)} uniforms={uniforms} toneMapped={false} transparent />
    </>
  )
}
