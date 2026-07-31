import { router } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import {
  ActivityIndicator,
  FlatList,
  Pressable,
  RefreshControl,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { BookClubRow } from '@/components/BookClubRow';
import { useAuth } from '@/contexts/AuthContext';
import { Colors } from '@/constants/Theme';
import type { BookClub } from '@/models/BookClub';
import { fetchMyBookClubs } from '@/services/bookClubService';

export default function MyBookClubsScreen() {
  const { currentUser } = useAuth();
  const [bookClubs, setBookClubs] = useState<BookClub[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const loadMyBookClubs = useCallback(async () => {
    if (!currentUser?.id) return;
    try {
      const clubs = await fetchMyBookClubs(currentUser.id);
      setBookClubs(clubs);
    } catch (error) {
      console.error('Error fetching my book clubs:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, [currentUser?.id]);

  useEffect(() => {
    loadMyBookClubs();
  }, [loadMyBookClubs]);

  return (
    <View style={styles.screen}>
      <Text style={styles.heading}>My BookClubs</Text>

      {loading ? (
        <ActivityIndicator
          size="large"
          color={Colors.darkMaroon}
          style={styles.loader}
        />
      ) : (
        <FlatList
          data={bookClubs}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.list}
          refreshControl={
            <RefreshControl
              refreshing={refreshing}
              onRefresh={() => {
                setRefreshing(true);
                loadMyBookClubs();
              }}
            />
          }
          renderItem={({ item }) => (
            <Pressable
              style={styles.row}
              onPress={() => router.push(`/bookclub/${item.id}`)}
            >
              <BookClubRow club={item} />
            </Pressable>
          )}
          ListEmptyComponent={
            <Text style={styles.empty}>
              You haven't joined any book clubs yet.
            </Text>
          }
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.oliveGreen,
    padding: 16,
  },
  heading: {
    fontSize: 28,
    fontWeight: '700',
    color: Colors.darkMaroon,
    marginBottom: 16,
    textAlign: 'center',
  },
  list: {
    paddingBottom: 24,
  },
  row: {
    backgroundColor: Colors.offWhite,
    borderRadius: 8,
    padding: 16,
    marginBottom: 8,
  },
  loader: {
    marginTop: 40,
  },
  empty: {
    textAlign: 'center',
    color: Colors.deepPurple,
    marginTop: 40,
    fontSize: 16,
  },
});
