class AuthHelper {
	static extractPayload(): Auth.PayloadContent | null {
		try {
			const cookieArr = document.cookie.split(";");

			for (let i = 0; i < cookieArr.length; i++) {
				const cookiePair = cookieArr[i].split("=");

				// Removing whitespace at the beginning of the cookie name
				// and compare it with the given string
				if ("payload" == cookiePair[0].trim()) {
					// Remove initial "payload=" tag not part of actual payload
					const cleanToken = decodeURIComponent(cookiePair[1]).replace("payload=", "");

					// Base64url decode the payload
					const payloadB64 = cleanToken.replace(/-/g, "+").replace(/_/g, "/");
					const payloadStr = window.atob(payloadB64);

					// Parse the payload as JSON
					const payload = JSON.parse(payloadStr);

					return payload;
				}
			}

			// Return null if the cookie by name is not found
			return null;
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}

	static isJWTExpired(): boolean {
		try {
			const payload = this.extractPayload();

			if (!payload) return true;

			const currentTime = Math.floor(Date.now() / 1000);

			return (payload?.exp ?? 0) < currentTime;
		} catch (error: any) {
			console.log(error);
			throw error;
		}
	}
}

export class Helpers {
	static auth = AuthHelper;
}
