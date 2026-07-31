import { useLocalSearchParams, router } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import {
  ActivityIndicator,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';

import { Button } from '@/components/Button';
import { useAuth } from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import {
  createBookClub,
  fetchBookClub,
  updateBookClub,
} from '@/services/bookClubService';

function generateId(): string {
  return `${Date.now()}-${Math.random().toString(36).slice(2, 11)}`;
}

export default function BookClubFormScreen() {
  const { id } = useLocalSearchParams<{ id?: string }>();
  const { currentUser } = useAuth();
  const isEditMode = Boolean(id);

  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [locationName, setLocationName] = useState('');
  const [latitude, setLatitude] = useState('');
  const [longitude, setLongitude] = useState('');
  const [nextMeetingDate, setNextMeetingDate] = useState(
    new Date().toISOString().split('T')[0],
  );
  const [loading, setLoading] = useState(isEditMode);
  const [submitting, setSubmitting] = useState(false);

  const loadBookClub = useCallback(async () => {
    if (!id) return;
    try {
      const club = await fetchBookClub(id);
      if (club) {
        setName(club.name);
        setDescription(club.description);
        setLocationName(club.locationName ?? '');
        setLatitude(club.latitude?.toString() ?? '');
        setLongitude(club.longitude?.toString() ?? '');
        setNextMeetingDate(club.nextMeetingDate.toISOString().split('T')[0]);
      }
    } catch (error) {
      console.error('Error loading book club:', error);
    } finally {
      setLoading(false);
    }
  }, [id]);

  useEffect(() => {
    if (isEditMode) {
      loadBookClub();
    }
  }, [isEditMode, loadBookClub]);

  async function handleSave() {
    if (!currentUser) return;
    setSubmitting(true);
    try {
      const lat = parseFloat(latitude) || 0;
      const lng = parseFloat(longitude) || 0;
      const meetingDate = new Date(nextMeetingDate);

      if (isEditMode && id) {
        await updateBookClub(id, {
          name,
          description,
          locationName,
          latitude: lat,
          longitude: lng,
          nextMeetingDate: meetingDate,
        });
      } else {
        await createBookClub({
          id: generateId(),
          name,
          description,
          owner: currentUser.id,
          nextMeetingDate: meetingDate,
          locationName,
          latitude: lat,
          longitude: lng,
        });
      }
      router.back();
    } catch (error) {
      console.error('Error saving book club:', error);
    } finally {
      setSubmitting(false);
    }
  }

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" color={Colors.darkMaroon} />
      </View>
    );
  }

  return (
    <ScrollView style={styles.screen} contentContainerStyle={styles.content}>
      <Text style={styles.sectionTitle}>Book Club Details</Text>

      <FormField label="Name" value={name} onChangeText={setName} />
      <FormField
        label="Description"
        value={description}
        onChangeText={setDescription}
        multiline
      />
      <FormField
        label="Next Meeting Date (YYYY-MM-DD)"
        value={nextMeetingDate}
        onChangeText={setNextMeetingDate}
      />
      <FormField
        label="Location Name"
        value={locationName}
        onChangeText={setLocationName}
      />
      <FormField
        label="Latitude"
        value={latitude}
        onChangeText={setLatitude}
        keyboardType="decimal-pad"
      />
      <FormField
        label="Longitude"
        value={longitude}
        onChangeText={setLongitude}
        keyboardType="decimal-pad"
      />

      <View style={styles.buttonWrap}>
        <Button
          title={isEditMode ? 'Save Changes' : 'Create Book Club'}
          onPress={handleSave}
          disabled={!name || !description || submitting}
        />
      </View>
    </ScrollView>
  );
}

function FormField({
  label,
  value,
  onChangeText,
  multiline = false,
  keyboardType = 'default',
}: {
  label: string;
  value: string;
  onChangeText: (text: string) => void;
  multiline?: boolean;
  keyboardType?: 'default' | 'decimal-pad';
}) {
  return (
    <View style={styles.field}>
      <Text style={styles.label}>{label}</Text>
      <TextInput
        value={value}
        onChangeText={onChangeText}
        style={[styles.input, multiline && styles.multiline]}
        multiline={multiline}
        keyboardType={keyboardType}
        placeholderTextColor={Colors.deepPurple}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.offWhite,
  },
  content: {
    padding: 16,
    gap: 12,
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: Colors.darkMaroon,
    marginBottom: 8,
  },
  field: {
    gap: 6,
  },
  label: {
    fontSize: 14,
    fontWeight: '600',
    color: Colors.darkMaroon,
  },
  input: {
    backgroundColor: Colors.offWhite,
    borderWidth: 1,
    borderColor: Colors.tan,
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    fontSize: 16,
    color: Colors.darkMaroon,
  },
  multiline: {
    minHeight: 80,
    textAlignVertical: 'top',
  },
  buttonWrap: {
    alignItems: 'center',
    marginTop: 16,
    marginBottom: 32,
  },
});
