import { router } from "expo-router";
import { View, Text, TouchableOpacity } from "react-native";

export default function SignIn() {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>Sign In</Text>
      <TouchableOpacity onPress={() => router.push("/(app)/(tabs)")}>
        <Text>Navigate to Root</Text>
      </TouchableOpacity>
    </View>
  );
}
