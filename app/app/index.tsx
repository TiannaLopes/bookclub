import { Redirect } from 'expo-router';
import { ActivityIndicator, View } from 'react-native';

import { useAuth } from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';

export default function Index() {
  const { userSession, loading } = useAuth();

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: Colors.oliveGreen }}>
        <ActivityIndicator size="large" color={Colors.darkMaroon} />
      </View>
    );
  }

  if (userSession) {
    return <Redirect href="/(tabs)" />;
  }

  return <Redirect href="/(auth)/login" />;
}
