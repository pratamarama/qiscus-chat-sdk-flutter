import 'package:qiscus_chat_sdk/src/domain/user/user-model.dart';

enum QMessageType {
  text,
  custom,
  attachment,
}

extension QMessageTypeString on QMessageType {
  String get string {
    switch (this) {
      case QMessageType.attachment:
        return 'file_attachment';
      case QMessageType.custom:
        return 'custom';
      case QMessageType.text:
      default:
        return 'text';
    }
  }
}

class QMessage {
  int id;
  int chatRoomId;
  int previousMessageId;
  String uniqueId;
  String text;
  QMessageStatus status;
  QMessageType type;
  Map<String, dynamic>? extras;
  Map<String, dynamic>? payload;
  QUser sender;
  DateTime timestamp;

  QMessage({
    required this.id,
    required this.chatRoomId,
    required this.previousMessageId,
    required this.uniqueId,
    required this.text,
    required this.status,
    required this.type,
    required this.extras,
    required this.payload,
    required this.sender,
    required this.timestamp,
  });

  @override
  String toString() => 'QMessage('
      ' id=$id,'
      ' text=$text,'
      ' chatRoomId=$chatRoomId,'
      ' sender=$sender,'
      ' uniqueId=$uniqueId,'
      ' type=$type,'
      ' status=$status,'
      ' extras=$extras,'
      ' payload=$payload,'
      ' timestamp=$timestamp,'
      ' previousMessageId=$previousMessageId'
      ')';

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QMessage &&
          runtimeType == other.runtimeType &&
          uniqueId == other.uniqueId;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => uniqueId.hashCode;
}

enum QMessageStatus {
  sending,
  sent,
  delivered,
  read,
}

extension QMessageStatusStr on QMessageStatus {
  String get string {
    switch (this) {
      case QMessageStatus.sending:
        return 'sending';
      case QMessageStatus.delivered:
        return 'delivered';
      case QMessageStatus.read:
        return 'read';
      case QMessageStatus.sent:
      default:
        return 'sent';
    }
  }
}