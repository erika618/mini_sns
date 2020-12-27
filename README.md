# README

# アプリ名

mini-sns

# URL
Herokuによるデプロイ
https://mini-sns-1227.herokuapp.com/

# 説明

新規登録時に、SNS認証（Facebook・Googleアカウント）を利用して登録することができます。また、SNS認証で新規登録する際は、パスワードが自動生成され、ユーザーがパスワードを入力しなくて済むようになっています。


# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| :----------------- | :----- | :-----------|
| nickname           | string | null: false |
| lastname           | string | null: false |
| firstname          | string | null: false |
| birthday           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

## Association
- has_many :sns_credentials

## sns_credentials テーブル

| Column    | Type       | Options           |
| :-------- | :--------- | :-----------------|
| provider  | string     |                   |
| uid       | string     |                   |
| user      | references | foreign_key: true |

## Association
- belongs_to :user




