import { router } from 'expo-router';
import { StyleSheet, Text, View } from 'react-native';

import { Button } from '@/components/Button';
import { useAuth } from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import { getInitials } from '@/models/User';

export default function ProfileScreen() {
  const { currentUser, signOut } = useAuth();

  async function handleSignOut() {
    await signOut();
    router.replace('/(auth)/login');
  }

  if (!currentUser) {
    return (
      <View style={styles.screen}>
        <Text style={styles.notFound}>User not found</Text>
      </View>
    );
  }

  return (
    <View style={styles.screen}>
      <View style={styles.header}>
        <Text style={styles.title}>My Account</Text>
      </View>

      <View style={styles.avatar}>
        <Text style={styles.initials}>{getInitials(currentUser)}</Text>
      </View>

      <View style={styles.info}>
        <Text style={styles.name}>
          {currentUser.firstName} {currentUser.lastName}
        </Text>
        <Text style={styles.email}>{currentUser.email}</Text>
      </View>

      <View style={styles.actions}>
        <Button title="Sign Out" onPress={handleSignOut} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.oliveGreen,
    alignItems: 'center',
    padding: 24,
  },
  header: {
    width: '100%',
    backgroundColor: Colors.tan,
    opacity: 0.9,
    borderRadius: 10,
    paddingVertical: 24,
    alignItems: 'center',
    marginBottom: 24,
  },
  title: {
    fontSize: 32,
    fontWeight: '700',
    color: Colors.darkMaroon,
  },
  avatar: {
    width: 72,
    height: 72,
    borderRadius: 36,
    backgroundColor: Colors.tan,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  initials: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.offWhite,
  },
  info: {
    alignItems: 'center',
    gap: 4,
    marginBottom: 32,
  },
  name: {
    fontSize: 16,
    fontWeight: '600',
    color: Colors.darkMaroon,
  },
  email: {
    fontSize: 14,
    color: Colors.offWhite,
  },
  actions: {
    gap: 12,
  },
  notFound: {
    color: Colors.darkMaroon,
    fontSize: 16,
  },
});
