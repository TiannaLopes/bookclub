import { router } from 'expo-router';
import { useState } from 'react';
import {
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { Button } from '@/components/Button';
import { FirebaseConfigBanner } from '@/components/FirebaseConfigBanner';
import { InputView } from '@/components/InputView';
import {
  isValidEmail,
  isValidPassword,
  useAuth,
} from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import { isFirebaseConfigured } from '@/lib/firebase';
import { getFirebaseErrorMessage } from '@/lib/firebaseErrors';

export default function LoginScreen() {
  const { signIn } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const formIsValid =
    isFirebaseConfigured && isValidEmail(email) && isValidPassword(password);

  async function handleSignIn() {
    if (!formIsValid || submitting) {
      return;
    }

    setSubmitting(true);
    setError('');
    try {
      await signIn(email.trim(), password);
      router.replace('/(tabs)');
    } catch (err) {
      setError(getFirebaseErrorMessage(err));
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <KeyboardAvoidingView
      style={styles.screen}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerStyle={styles.scroll}
        keyboardShouldPersistTaps="handled"
      >
        <View style={styles.card}>
          <Text style={styles.title}>Sign In</Text>

          <FirebaseConfigBanner />

          <InputView
            value={email}
            onChangeText={setEmail}
            title="Email Address"
            placeholder="name@example.com"
            autoCapitalize="none"
            keyboardType="email-address"
          />

          <InputView
            value={password}
            onChangeText={setPassword}
            title="Password"
            placeholder="Enter your password"
            secureTextEntry
          />

          {error ? <Text style={styles.error}>{error}</Text> : null}

          <View style={styles.buttonWrap}>
            <Button
              title={submitting ? 'SIGNING IN...' : 'SIGN IN'}
              onPress={handleSignIn}
              disabled={!formIsValid || submitting}
            />
          </View>

          <Pressable
            onPress={() => router.push('/signup')}
            style={styles.link}
          >
            <Text style={styles.linkText}>
              Don't have an account?{' '}
              <Text style={styles.linkBold}>Sign up</Text>
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.oliveGreen,
  },
  scroll: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: 20,
  },
  card: {
    backgroundColor: Colors.tan,
    opacity: 0.95,
    borderRadius: 10,
    padding: 24,
    gap: 16,
  },
  title: {
    fontSize: 32,
    fontWeight: '700',
    color: Colors.darkMaroon,
    marginBottom: 8,
  },
  buttonWrap: {
    alignItems: 'center',
    marginTop: 8,
  },
  error: {
    color: '#b91c1c',
    fontSize: 14,
  },
  link: {
    marginTop: 16,
    alignSelf: 'center',
  },
  linkText: {
    fontSize: 14,
    color: Colors.deepPurple,
  },
  linkBold: {
    fontWeight: '700',
  },
});
