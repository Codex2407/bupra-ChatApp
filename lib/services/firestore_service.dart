import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Users
  Stream<UserModel?> getUserStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromMap(doc.data()!, uid) : null);
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? UserModel.fromMap(doc.data()!, uid) : null;
  }

  Future<List<UserModel>> searchUsers(String query) async {
    // Search by displayName (username#number format)
    // This allows searching by both "bugra" and "bugra#1234"
    final snapshot = await _firestore
        .collection('users')
        .where('displayName', isGreaterThanOrEqualTo: query)
        .where('displayName', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(20)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Check if email already exists
  Future<bool> emailExists(String email) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Check if username already exists (case-insensitive)
  Future<bool> usernameExists(String username) async {
    try {
      // Normalize username to lowercase for comparison
      final normalizedUsername = username.toLowerCase().trim();

      if (normalizedUsername.isEmpty) {
        return false;
      }

      // Get all users and check case-insensitively
      final snapshot = await _firestore
          .collection('users')
          .get();

      // Check if any username matches (case-insensitive)
      for (var doc in snapshot.docs) {
        final userData = doc.data();
        final existingUsername = userData['username']?.toString().toLowerCase().trim() ?? '';
        if (existingUsername.isNotEmpty && existingUsername == normalizedUsername) {
          return true;
        }
      }

      return false;
    } catch (e) {
      // If query fails, return false
      // In production, you might want to log this to a monitoring service
      return false;
    }
  }

  // Friends
  Future<void> addFriend(String uid, String friendUid) async {
    await _firestore
        .collection('friends')
        .doc(uid)
        .collection('friends')
        .doc(friendUid)
        .set({'addedAt': FieldValue.serverTimestamp()});
  }

  Stream<List<String>> getFriendsStream(String uid) {
    return _firestore
        .collection('friends')
        .doc(uid)
        .collection('friends')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Future<List<UserModel>> getFriends(String uid) async {
    final friendsSnapshot = await _firestore
        .collection('friends')
        .doc(uid)
        .collection('friends')
        .get();

    final friendUids = friendsSnapshot.docs.map((doc) => doc.id).toList();
    if (friendUids.isEmpty) return [];

    final usersSnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: friendUids)
        .get();

    return usersSnapshot.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Chats
  Stream<List<ChatModel>> getChatsStream(String uid) {
    return _firestore
        .collection('chats')
        .where('members', arrayContains: uid)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<String> createOneToOneChat(String uid1, String uid2) async {
    // Check if chat already exists
    final existingChats = await _firestore
        .collection('chats')
        .where('members', arrayContains: uid1)
        .where('isGroup', isEqualTo: false)
        .get();

    for (var doc in existingChats.docs) {
      final chat = ChatModel.fromMap(doc.data(), doc.id);
      if (chat.members.length == 2 &&
          chat.members.contains(uid1) &&
          chat.members.contains(uid2)) {
        return doc.id;
      }
    }

    // Create new chat
    final chatRef = _firestore.collection('chats').doc();
    await chatRef.set({
      'isGroup': false,
      'members': [uid1, uid2],
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return chatRef.id;
  }

  Future<String> createGroupChat(String name, List<String> members) async {
    final chatRef = _firestore.collection('chats').doc();
    await chatRef.set({
      'isGroup': true,
      'name': name,
      'members': members,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return chatRef.id;
  }

  Stream<ChatModel?> getChatStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((doc) => doc.exists ? ChatModel.fromMap(doc.data()!, chatId) : null);
  }

  // Messages
  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> sendMessage(
    String chatId,
    String senderId,
    String? text,
    String? imageUrl,
  ) async {
    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'senderId': senderId,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Update chat last message
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text ?? 'Image',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}

