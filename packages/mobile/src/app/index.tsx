import { Redirect } from "expo-router";

export default function Index() {
  const isLoading = false;
  const session = true;

  if (isLoading) return null;

  if (session) {
    return <Redirect href="/(app)/(tabs)" />;
  }

  return <Redirect href="/auth/sign-in" />;
}
