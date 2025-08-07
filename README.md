# Beauty Tracker

Beauty Tracker 是一款使用 Flutter 和 Supabase 開發的應用程式，旨在幫助使用者追蹤與記錄個人美容品相關的期限。

<img width="200" height="415" alt="image" src="https://github.com/user-attachments/assets/57bfbe17-3b52-41bb-99a2-c07dcaedbb99" />


## 🚀 開始使用 (Getting Started)

在開始之前，請確保您已經安裝了 Flutter SDK 與 FVM。

1.  **Clone 專案庫**
    ```bash
    git clone [您的專案庫 URL]
    cd beauty-tracker
    ```

2.  **安裝依賴套件**
    ```bash
    fvm flutter pub get
    ```

3.  **設定環境變數**
    複製 `.env.example` 檔案並重新命名為 `.env.development`/`.env.production`。
    ```bash
    cp .env.example [.env.development|.env.production]
    ```
    接著，填入您在 Supabase และ Google Cloud Platform 中設定的對應變數。

    ```dotenv
    # .env
    SUPABASE_URL=YOUR_SUPABASE_URL
    SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
    
    # google credentials
    GOOGLE_WEB_CLIENT_ID=YOUR_GOOGLE_WEB_CLIENT_ID
    GOOGLE_IOS_CLIENT_ID=YOUR_GOOGLE_IOS_CLIENT_ID
    # Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID
    GOOGLE_IOS_URL_SCHEME=YOUR_GOOGLE_IOS_REVERSED_CLIENT_ID
    ```
4. **執行腳本**
   將為您生成 .env 檔案
   ```bash
   fvm dart run scripts/setup_env.dart [dev|prod]
   ```
5.  **執行應用程式**
    ```bash
    fvm flutter run
    ```

## 🔧 後端設定 (Backend Setup - Supabase)

本專案使用 [Supabase](https://supabase.io/) 作為後端服務。

### 1. 基本認證設定

在您的 Supabase 專案儀表板中，前往 **Authentication > Providers > Email** 進行以下設定：

* **Confirm email:** `Off` (關閉)
* **Email OTP Length:** `6`

### 2. 資料庫遷移 (Migration)

若您有本地的資料庫結構變更需要同步至 Supabase，請使用 Supabase CLI：

1.  **連結您的 Supabase 專案:**
    ```bash
    supabase link --project-ref [YOUR_PROJECT_ID]
    ```

2.  **推送本地變更至雲端資料庫:**
    ```bash
    supabase db push
    ```

### 3. 密碼重設 (Reset Password)

為了客製化密碼重設流程，我們進行了以下設定：

1.  **更改信件範本:**
    前往 **Emails > Reset Password**，將預設的信件內容改為使用 Token 的客製化版本，以符合 App 的驗證流程。

2.  **更改 SMTP 服務器:**
    為了提升信件發送的穩定性與信譽，我們客製化了 SMTP 服務器。詳細設定步驟請參考此篇文章：[iWare 商務中心 - Supabase 更改 SMTP Provider](https://www.iware.com.tw/blog-1201.html)。

### 4. Google OAuth 登入設定

要啟用 Google 登入，請依照以下步驟設定：

1.  **在 Google Cloud Platform 建立 OAuth 客戶端 ID**
    * 您需要分別為 Web, Android, iOS 建立對應的 OAuth 2.0 Client ID。
    * **注意:** Android 平台的 `debug` 與 `release` 版本需要使用不同的 SHA-1 指紋。
    * 詳細教學可參考此篇文章：[Implementing Google Sign-In in Flutter with Supabase](https://medium.com/@fianto74/implementing-google-sign-in-authentication-in-flutter-with-supabase-acf7f33a98b1)

2.  **在 Supabase 中設定 Google Provider**
    * 前往 **Authentication > Providers > Google**。
    * **Enable Sign in with Google:** `On` (開啟)
    * **Skip nonce checks:** `On` (開啟) - *注意：僅在您了解其安全影響時才開啟，對於 iOS 登入是必要的步驟。*
    * 填入您在 Google Cloud Platform 取得的 **Web Client ID** 和 **Client Secret**。
