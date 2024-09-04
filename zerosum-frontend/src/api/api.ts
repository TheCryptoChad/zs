class _GeneralAPI {
	static async _sendRequest(
		options: API.RequestOptions,
		data?: object
		// eslint-disable-next-line
	): Promise<any> {
		const { method, endpoint } = options;
		try {
			const res: Response = await fetch(`${import.meta.env.VITE_BACKEND_URL}${endpoint}`, {
				method,
				credentials: "include",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(data),
			});

			if (!res.ok) {
				const text = await res.text();
				let error = "An error occurred";
				if (text) {
					const responseBody = JSON.parse(text);
					error = responseBody.message || error;
				}
				if (res.status === 401) {
					// Redirect to "/" when status is 401
					window.location.href = "/";
				}
				throw new Error(error);
			}

			const text = await res.text();
			return text ? JSON.parse(text) : {};
		} catch (error) {
			console.error("Network or server error:", error);
			throw error;
		}
	}
}

class _AuthAPI extends _GeneralAPI {
	public static async getToken(code: string | null): Promise<void> {
		try {
			return await super._sendRequest({
				method: "POST",
				endpoint: `/auth/getToken/${code}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async logout(): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/auth/logout`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _BlockchainAPI extends _GeneralAPI {
	public static async getAbi(): Promise<{
		erc20Abi: [];
		erc1155Abi: [];
		blueprintCollectionAbi: [];
		referralAbi: [];
	}> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/blockchain/get-abi`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _ResourceAPI extends _GeneralAPI {
	public static async getBalances(): Promise<Entity.Resources> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/resource/get-balances`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async getAll(): Promise<{ [key: number]: Entity.Resources }> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/resource/get-all`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async claimResources(chains: number[]): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/resource/claim-resources/${chains.join("-")}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async payGas(chain: number): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/resource/pay-gas/${chain}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async clearPendingBalances(): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/resource/clear-pending-balances`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _StatsAPI extends _GeneralAPI {
	public static async fetchStats(resource: "astralite" | "samarium" | "calamarite" | "all", type: "amount" | "tx" | "faucet" | "gas", scope: "dashboard" | "leaderboard", chain: number) {
		try {
			const params = new URLSearchParams({
				resource: resource,
				type: type,
				scope: scope,
				chain: String(chain),
			}).toString();
			return await super._sendRequest({
				method: "GET",
				endpoint: `/stats/fetch-stats?${params}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async fetchLogins(type: "total" | "consecutive" | "daily" | "referrals" | "") {
		try {
			if (type) {
				const params = new URLSearchParams({
					type: type,
				}).toString();
				return await super._sendRequest({
					method: "GET",
					endpoint: `/stats/fetch-logins?${params}`,
				});
			}
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _TilesAPI extends _GeneralAPI {
	public static async getAllExhausted(): Promise<Entity.Tile[]> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/tile/get-all-exhausted`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async getType(vesselId: number): Promise<{ tiletype: number; probabilities: Entity.Resources }> {
		try {
			const params = new URLSearchParams({
				vesselId: vesselId.toString(),
			}).toString();
			return await super._sendRequest({
				method: "GET",
				endpoint: `/tile/get-type?${params}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async radarScan(vesselId: number): Promise<{ type: number; x: number; y: number }[]> {
		try {
			const params = new URLSearchParams({
				vesselId: vesselId.toString(),
			}).toString();
			return await super._sendRequest({
				method: "GET",
				endpoint: `/tile/radar-scan?${params}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _UserAPI extends _GeneralAPI {
	public static async registerAddress(address: Config.HexString, message: string, signature: Config.HexString): Promise<Response> {
		try {
			return await super._sendRequest(
				{
					method: "PUT",
					endpoint: "/user/register-address",
				},
				{
					address,
					message,
					signature,
				}
			);
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async addPendingReferral(code: string): Promise<void> {
		try {
			return await super._sendRequest({
				method: "PUT",
				endpoint: `/user/add-pending-referral/${code}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async getSelf(): Promise<Entity.Self> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: "/user/get-user",
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async getReferral(referralCode: string): Promise<{address: string, messageWithNonce: string, signedMessage: string}> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: `/user/get-referral/${referralCode}`,
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async useFaucet(): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: "/user/use-faucet",
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async linkUsername(): Promise<void> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: "/user/link-username",
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _UpdateAPI extends _GeneralAPI {
	public static async getAll(): Promise<Update[]> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: "/update/get-all",
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

class _VesselAPI extends _GeneralAPI {
	public static async getAll(): Promise<API.VesselResponse[]> {
		try {
			return await super._sendRequest({
				method: "GET",
				endpoint: "/vessel/get-all",
			});
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async deploy(vesselId: number, x: number, y: number) {
		try {
			return await super._sendRequest(
				{
					method: "POST",
					endpoint: "/vessel/deploy",
				},
				{
					vesselId: vesselId,
					x: x,
					y: y,
				}
			);
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async move(vesselId: number, x: number, y: number) {
		try {
			return await super._sendRequest(
				{
					method: "PUT",
					endpoint: "/vessel/move",
				},
				{
					vesselId: vesselId,
					x: x,
					y: y,
				}
			);
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	public static async startMining(vesselId: number) {
		try {
			return await super._sendRequest(
				{
					method: "PUT",
					endpoint: "/vessel/start-mining",
				},
				{
					vesselId: vesselId,
				}
			);
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
	public static async finishMining(vesselId: number) {
		try {
			return await super._sendRequest(
				{
					method: "PUT",
					endpoint: "/vessel/finish-mining",
				},
				{
					vesselId: vesselId,
				}
			);
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

export class API {
	static auth = _AuthAPI;
	static blockchain = _BlockchainAPI;
	static user = _UserAPI;
	static update = _UpdateAPI;
	static vessel = _VesselAPI;
	static resources = _ResourceAPI;
	static stats = _StatsAPI;
	static tiles = _TilesAPI;
}
