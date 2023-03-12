import pickle
import re
import string
from nltk import word_tokenize
import arabicstopwords.arabicstopwords as asw

class Model:
    model = None
    tokenizer = None
    
    def __init__(self):
        self.model = pickle.load(open('assets/model.pkl','rb'))
        self.tokenizer = pickle.load(open('assets/tokenizer.pkl', 'rb'))
        
    def classify(self, msg):
        return self.model.predict(self.tokenizer.transform(self.__remve_noise([msg])))
    
    def __remve_noise(self, cases):
        corpus=[]
        for case in cases:
            s=case.lower()
            s=re.sub("[0-9]",'',s)
            words=word_tokenize(s)
            word=[w for w in words if w not in asw.stopwords_list() if w not in string.punctuation]
            s=" ".join(word)
            corpus.append(s)
        return corpus