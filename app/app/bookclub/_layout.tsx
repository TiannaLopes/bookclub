import { Stack } from 'expo-router';

export default function BookClubLayout() {
  return (
    <Stack
      screenOptions={{
        headerStyle: { backgroundColor: '#C9D3BE' },
        headerTintColor: '#3D0814',
      }}
    >
      <Stack.Screen name="[id]" options={{ title: 'Book Club' }} />
      <Stack.Screen name="form" options={{ title: 'Book Club' }} />
    </Stack>
  );
}
