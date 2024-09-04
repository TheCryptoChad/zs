import { Navigate, Outlet, Route, RouterProvider, createBrowserRouter, createRoutesFromElements, useRouteError } from "react-router-dom";
import AuthCallback from "./pages/AuthCallback";
import Game from "./pages/Game";
import { Helpers } from "./utils/helpers";
import { Login } from "./pages/Login";
import { Showroom } from "./pages/Showroom/Showroom";
import { Leaderboard } from "./pages/Leaderboard";
import { Workbench } from "./pages/Workbench";
import { Referrals } from "./pages/Referrals";
import { Button, Flex, Heading, Text, Image, Spacer, VStack } from "@chakra-ui/react";

const Protected = ({ children }: { children: JSX.Element }) => {
	const isJWTExpired = Helpers.auth.isJWTExpired()

	if (isJWTExpired) {
		return <Navigate to="/" replace />;
	}

	return children;
};


const App = () => {
	const router = createBrowserRouter(
		createRoutesFromElements(
			<Route
				path="/"
				element={<Root />}
				errorElement={<ErrorBoundary />}
			>
				<Route
					index
					element={
						<Login />
					}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="/leaderboard"
					element={
						<Protected>
							<Leaderboard />
						</Protected>
					}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="/workbench"
					element={
						<Protected>
							<Workbench />
						</Protected>
					}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="/referrals"
					element={
						<Protected>
							<Referrals />
						</Protected>
					}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="/auth/callback"
					element={<AuthCallback />}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="/game"
					element={
						<Protected>
							<Game />
						</Protected>
					}
					errorElement={<ErrorBoundary />}
				/>
				<Route
					path="view"
					element={
						<Protected>
							<Showroom />
						</Protected>
					}
					errorElement={<ErrorBoundary />}
				/>
			</Route>
		)
	);

	return <RouterProvider router={router} />;
};

const Root = (): JSX.Element => {
	return <Outlet />;
};

const ErrorBoundary = (): JSX.Element => {
	const error: any = useRouteError();
	return (
		<Flex
			flexDirection="column"
			justifyContent="space-evenly"
			alignItems="center"
			gap={2}
			height="100vh"
			width="100vw"
		>
			<Image src={"/backgrounds/workbench_background.jpeg"} width="100%" height="100%" position="absolute" top="0%" left="0%" zIndex={0}/>
			<Heading color={"samaWhite"} fontFamily={"Orbitron"} zIndex={1}>
				Oops! Something went wrong...
			</Heading>
			<VStack
				className="gildedBorder"
				w={["70%", "30%"]}
				color={"samaWhite"}
				bg={"samaBlackFade"}
				gap={2}
				py={4}
				mb={10}
				boxShadow="5px 5px 5px rgba(0, 0, 0, 0.7)"
				zIndex={1}
			>
				<Spacer />
				<Text fontFamily={"Raleway"} textAlign={"center"} mb={[2, 4]} color="red.500" zIndex={1}>{error.message}</Text>
				<Button
					bg="#25434F"
					color="white"
					fontFamily={"Orbitron"}
					letterSpacing={1.5}
					px={8}
					mb={[0, 4]}
					onClick={() => location.replace("/")}
					_hover={{
						background: "#0EEBA8",
						color: "#191919",
						transform: "translateY(-3px)",
						boxShadow: "0px 3px 10px #0EEBA8"
					}}
					transition="0.3s"
				>
					RETURN TO GAME
				</Button>
			</VStack>
		</Flex>
	)
};

export default App;
