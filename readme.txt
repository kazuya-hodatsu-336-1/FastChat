git clone https://github.com/kazuya-hodatsu-336-1/FastChat.git
python -m venv venv
source venv/bin/activate
cd FastChat
pip install -e ".[model_worker,webui]"
pip install anthropic openai==0.28
pip install plotly kaleido
export OPENAI_API_KEY=xxxxxx
huggingface-cli login --token xxxxxx

#Gen
[Qwen/Qwen3-4B]*********************************
python gen_api_answer.py --model Qwen/Qwen3-4B --openai-api-base http://localhost:8000/v1 --parallel 50 --max-tokens 32768 --force-temperature 0.6

python gen_api_answer.py --model Qwen/Qwen3-4B --openai-api-base http://localhost:8000/v1 --parallel 50 --bench-name japanese_mt_bench --max-tokens 32768 --force-temperature 0.6

[AXCXEPT/Qwen3-4B-HCSD_MPO_SFT1]***********
python gen_api_answer.py --model AXCXEPT/Qwen3-4B-HCSD_MPO_SFT1 --openai-api-base http://localhost:8000/v1 --parallel 50  --max-tokens 32768 --force-temperature 0.6

python gen_api_answer.py --model AXCXEPT/Qwen3-4B-HCSD_MPO_SFT1 --openai-api-base http://localhost:8000/v1 --parallel 50 --bench-name japanese_mt_bench  --max-tokens 32768 --force-temperature 0.6


#Judge:
python gen_judgment.py --model-list Qwen3-4B --parallel 2
python gen_judgment.py --model-list Qwen3-4B --parallel 2 --bench-name japanese_mt_bench
python gen_judgment.py --model-list Qwen3-4B-HCSD_MPO_SFT1 --parallel 2 --bench-name japanese_mt_bench
python gen_judgment.py --model-list Qwen3-4B-HCSD_MPO_SFT1 --parallel 2