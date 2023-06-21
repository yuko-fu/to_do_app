# README
モデル名 |カラム名         |データ型 |
|---------|----------------|---------|
|User     |id              |integer  |
|         |name            |string   |
|         |email           |string   |
|         |password        |string   |
|         |password_digest |string  |



|モデル名 |カラム名  |データ型 |
|---------|----------|---------|
|Task     |id        |integer  |
|         |task_name |string   |
|         |content   |string   |
|         |status    |string   |
|         |limit_day |date     |
|         |user_id   |integer  |


モデル名 |カラム名    |データ型 |
|---------|-----------|---------|
|Label    |id         |integer  |
|         |label_name |string   |
|         |task_id    |integer  |

