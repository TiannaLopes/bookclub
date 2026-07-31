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
import { Colors } from '@/constants/Theme';
import type { BookClub } from '@/models/BookClub';
import { fetchAllBookClubs } from '@/services/bookClubService';

export default function FeedScreen() {
  const [bookClubs, setBookClubs] = useState<BookClub[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const loadBookClubs = useCallback(async () => {
    try {
      const clubs = await fetchAllBookClubs();
      setBookClubs(clubs);
    } catch (error) {
      console.error('Error fetching book clubs:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, []);

  useEffect(() => {
    loadBookClubs();
  }, [loadBookClubs]);

  return (
    <View style={styles.screen}>
      <Pressable
        style={styles.createButton}
        onPress={() => router.push('/bookclub/form')}
      >
        <Text style={styles.createButtonText}>Create Bookclub</Text>
      </Pressable>

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
                loadBookClubs();
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
            <Text style={styles.empty}>No book clubs yet. Create one!</Text>
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
  createButton: {
    backgroundColor: Colors.paleYellow,
    borderRadius: 15,
    paddingVertical: 12,
    paddingHorizontal: 20,
    alignSelf: 'center',
    marginBottom: 16,
  },
  createButtonText: {
    fontSize: 16,
    fontWeight: '700',
    color: Colors.darkMaroon,
  },
  list: {
    gap: 8,
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
