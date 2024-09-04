import styled, { keyframes, css } from "styled-components";

const NetworkSlider = () => {
	const networks = ["/login/manta_logo.png", "/login/exosama.png", "/login/base.png", "/login/subsquid.png"];

	return (
		<Marquee>
			<MarqueeGroup>
				{networks.map((network: string, index: number) => (
					<ImageGroup key={index}>
						<Image src={network} />
					</ImageGroup>
				))}
			</MarqueeGroup>
			<MarqueeGroup>
				{networks.map((network: string, index: number) => (
					<ImageGroup key={index}>
						<Image src={network} />
					</ImageGroup>
				))}
			</MarqueeGroup>
		</Marquee>
	);
};

export default NetworkSlider;

const Marquee = styled.div`
	display: flex;
	width: 50vw;
	overflow: hidden;
	user-select: none;

	mask-image: linear-gradient(to right, hsl(0 0% 0% / 0), hsl(0 0% 0% / 1) 10%, hsl(0 0% 0% / 1) 90%, hsl(0 0% 0% / 0));
`;

const scrollX = keyframes`
  from {
    left: translateX(0);
  }
  to {
    transform: translateX(-100%);
  }
`;

const common = css`
	flex-shrink: 0;
	display: flex;
	align-items: center;
	justify-content: space-around;
	white-space: nowrap;
	width: 100%;
	animation: ${scrollX} 10s linear infinite;
`;

const MarqueeGroup = styled.div`
	${common}
`;

const ImageGroup = styled.div`
	display: grid;
	place-items: center;
	width: clamp(10rem, 1rem + 40vmin, 30rem);
	padding: calc(clamp(10rem, 1rem + 30vmin, 30rem) / 10);
`;

const Image = styled.img`
	object-fit: contain;
	width: auto;
	height: 80%;
	aspect-ratio: 16/9;
	padding: 5px 20px;
`;
