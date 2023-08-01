from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from haystack.document_stores.elasticsearch import ElasticsearchDocumentStore
from haystack.nodes import BM25Retriever, FARMReader
from haystack.pipelines import ExtractiveQAPipeline

doc_store = ElasticsearchDocumentStore(
    host='elasticsearch',
    port=9200,
    username='', password='',
    index='unimy'
)

retriever = BM25Retriever(document_store=doc_store)

reader = FARMReader(model_name_or_path="deepset/roberta-base-squad2", use_gpu=True)

pipe = ExtractiveQAPipeline(reader, retriever)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get('/query')
async def get_query(q):
    prediction = pipe.run(query=q)
    return prediction['answers'][0].answer