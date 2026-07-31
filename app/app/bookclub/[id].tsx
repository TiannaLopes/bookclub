import { useLocalSearchParams, router } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import {
  ActivityIndicator,
  Linking,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { BookClubMap } from '@/components/BookClubMap';
import { Button } from '@/components/Button';
import { useAuth } from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import type { BookClub } from '@/models/BookClub';
import {
  deleteBookClub,
  fetchBookClub,
  joinBookClub,
  leaveBookClub,
} from '@/services/bookClubService';

export default function BookClubDetailScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { currentUser } = useAuth();
  const [bookClub, setBookClub] = useState<BookClub | null>(null);
  const [loading, setLoading] = useState(true);
  const [hasJoined, setHasJoined] = useState(false);

  const loadBookClub = useCallback(async () => {
    if (!id) return;
    try {
      const club = await fetchBookClub(id);
      setBookClub(club);
      if (club && currentUser) {
        setHasJoined(currentUser.joinedBookclubs?.includes(club.id) ?? false);
      }
    } catch (error) {
      console.error('Error fetching book club:', error);
    } finally {
      setLoading(false);
    }
  }, [id, currentUser]);

  useEffect(() => {
    loadBookClub();
  }, [loadBookClub]);

  async function handleJoinLeave() {
    if (!bookClub || !currentUser) return;
    try {
      if (hasJoined) {
        await leaveBookClub(bookClub.id, currentUser.id);
        setHasJoined(false);
      } else {
        await joinBookClub(bookClub.id, currentUser.id);
        setHasJoined(true);
      }
    } catch (error) {
      console.error('Error joining/leaving book club:', error);
    }
  }

  async function handleDelete() {
    if (!bookClub) return;
    try {
      await deleteBookClub(bookClub.id);
      router.back();
    } catch (error) {
      console.error('Error deleting book club:', error);
    }
  }

  function openInMaps() {
    if (!bookClub?.latitude || !bookClub?.longitude) return;
    const { latitude, longitude } = bookClub;
    const label = encodeURIComponent(bookClub.locationName ?? 'Book Club');
    const url =
      Platform.OS === 'ios'
        ? `maps:0,0?q=${label}@${latitude},${longitude}`
        : `geo:0,0?q=${latitude},${longitude}(${label})`;
    Linking.openURL(url);
  }

  if (loading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" color={Colors.darkMaroon} />
      </View>
    );
  }

  if (!bookClub) {
    return (
      <View style={styles.centered}>
        <Text style={styles.notFound}>Book club not found</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.screen} contentContainerStyle={styles.content}>
      <View style={styles.actions}>
        <Button
          title={hasJoined ? 'Leave' : 'Join'}
          onPress={handleJoinLeave}
          variant="secondary"
        />
        <Button
          title="Edit Book Club Details"
          onPress={() =>
            router.push({ pathname: '/bookclub/form', params: { id: bookClub.id } })
          }
          variant="secondary"
        />
        <Button title="Delete" onPress={handleDelete} variant="secondary" />
      </View>

      <Text style={styles.name}>{bookClub.name}</Text>
      <Text style={styles.description}>{bookClub.description}</Text>

      <View style={styles.meetingRow}>
        <Text style={styles.meetingLabel}>Next Meeting:</Text>
        <Text style={styles.meetingDate}>
          {bookClub.nextMeetingDate.toLocaleDateString()}
        </Text>
      </View>

      {bookClub.latitude != null && bookClub.longitude != null && (
        <View style={styles.locationSection}>
          <Text style={styles.locationName}>
            {bookClub.locationName ?? 'Location'}
          </Text>
          <BookClubMap
            latitude={bookClub.latitude}
            longitude={bookClub.longitude}
            locationName={bookClub.locationName}
          />
          {Platform.OS !== 'web' && (
            <Text style={styles.mapsLink} onPress={openInMaps}>
              Open in Maps
            </Text>
          )}
        </View>
      )}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.tan,
  },
  content: {
    padding: 16,
    gap: 12,
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: Colors.tan,
  },
  notFound: {
    color: Colors.darkMaroon,
    fontSize: 16,
  },
  actions: {
    gap: 8,
    alignItems: 'flex-start',
  },
  name: {
    fontSize: 28,
    fontWeight: '700',
    color: Colors.darkMaroon,
  },
  description: {
    fontSize: 16,
    color: Colors.darkMaroon,
    lineHeight: 22,
  },
  meetingRow: {
    flexDirection: 'row',
    gap: 8,
    alignItems: 'center',
  },
  meetingLabel: {
    fontSize: 16,
    fontWeight: '700',
    color: Colors.darkMaroon,
  },
  meetingDate: {
    fontSize: 14,
    color: Colors.darkMaroon,
  },
  locationSection: {
    gap: 8,
    marginTop: 8,
  },
  locationName: {
    fontSize: 16,
    fontWeight: '700',
    color: Colors.darkMaroon,
  },
  mapsLink: {
    color: '#2563eb',
    fontSize: 14,
    marginTop: 4,
  },
});
