#!/bin/bash

# 評価対象のフォルダ一覧
folders=(
  "/home/axcxept/trainings/evaling/FastChat/fastchat/llm_judge/data/mt_bench/model_answer"
  "/home/axcxept/trainings/evaling/FastChat/fastchat/llm_judge/data/japanese_mt_bench/model_answer"
)

# 各フォルダごとに処理
for folder in "${folders[@]}"; do
  # old フォルダを作成（存在しない場合）
  mkdir -p "$folder/old"

  for filepath in "$folder"/*.jsonl; do
    model_name=$(basename "$filepath" .jsonl)
    echo "Processing: $model_name"

    if [[ "$folder" == *"japanese_mt_bench"* ]]; then
      python gen_judgment.py --model-list "$model_name" --parallel 50 --bench-name japanese_mt_bench
    else
      python gen_judgment.py --model-list "$model_name" --parallel 50
    fi

    # 実行後に old フォルダへ移動
    mv "$filepath" "$folder/old/"
  done
done
