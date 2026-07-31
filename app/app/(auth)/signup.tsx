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
import { PasswordRequirements } from '@/components/PasswordRequirements';
import {
  isValidEmail,
  isValidPassword,
  useAuth,
} from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import { isFirebaseConfigured } from '@/lib/firebase';
import { getFirebaseErrorMessage } from '@/lib/firebaseErrors';

export default function SignUpScreen() {
  const { createUser } = useAuth();
  const [email, setEmail] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const passwordsMatch = password === confirmPassword;
  const formIsValid =
    isFirebaseConfigured &&
    isValidEmail(email) &&
    isValidPassword(password) &&
    passwordsMatch &&
    firstName.trim().length > 0 &&
    lastName.trim().length > 0;

  async function handleSignUp() {
    if (!formIsValid || submitting) {
      return;
    }

    setSubmitting(true);
    setError('');
    try {
      await createUser(
        email.trim(),
        password,
        firstName.trim(),
        lastName.trim(),
      );
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
          <Text style={styles.title}>Create Your Profile</Text>

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
            value={firstName}
            onChangeText={setFirstName}
            title="First Name"
            placeholder="Enter your first name"
          />
          <InputView
            value={lastName}
            onChangeText={setLastName}
            title="Last Name"
            placeholder="Enter your last name"
          />
          <InputView
            value={password}
            onChangeText={setPassword}
            title="Password"
            placeholder="At least 6 characters"
            secureTextEntry
          />
          <PasswordRequirements password={password} />
          <InputView
            value={confirmPassword}
            onChangeText={setConfirmPassword}
            title="Confirm Password"
            placeholder="Confirm your password"
            secureTextEntry
          />

          {!passwordsMatch && confirmPassword.length > 0 ? (
            <Text style={styles.hint}>Passwords do not match.</Text>
          ) : null}

          {error ? <Text style={styles.error}>{error}</Text> : null}

          <View style={styles.buttonWrap}>
            <Button
              title={submitting ? 'CREATING ACCOUNT...' : 'SIGN UP'}
              onPress={handleSignUp}
              disabled={!formIsValid || submitting}
            />
          </View>

          <Pressable
            onPress={() => router.push('/login')}
            style={styles.link}
          >
            <Text style={styles.linkText}>
              Already have an account?{' '}
              <Text style={styles.linkBold}>Sign in</Text>
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
  hint: {
    color: Colors.deepPurple,
    fontSize: 14,
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
