#%%
import PyPDF2
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import os
import sys
import pandas as pd
import timeit

def test_path():
    if os.getcwd()[-6:] == "python":
        os.chdir("..")
    sys.path.append("./python")
    print(os.getcwd())

test_path()

#%%
def count_bigrams(text_used, punctuations, stop_words):
    """Compute relative bigram frequency

    Parameters
    ----------
    text_used : str
        The text corpus for which bigrams should be counted
    punctuations, stop_words: list
        Words to be removed from the corpus
    
    Returns
    --------
    pd.DataFrame
        Ratio of frequency / nb of words for every bigram in the text
    """
    # Split text into tokens
    tokens = word_tokenize(text_used)
    
    # Remove stop words and punctuations
    tokens_relevant = \
        [word.lower() for word in tokens if not word in stop_words and \
            not word in punctuations]

    # Use only stubs for selected words
    tokens_relevant_red = []
    for w in tokens_relevant:
        if w[:6] == "financ":
            tokens_relevant_red.append(w[:6])
        elif w[:9] == "sustainab":
            tokens_relevant_red.append(w[:9])
        else:
            tokens_relevant_red.append(w)

    # Count single words:
    freq = nltk.FreqDist(tokens_relevant_red)
    total_words = sum(freq.values())

    # Count bigrams from filtered raw tokes
    bgs = nltk.bigrams(tokens_relevant_red)
    bgs_fdist = nltk.FreqDist(bgs)

    # Compute relative frequency of bigrams
    bgs_list = list(nltk.bigrams(tokens_relevant_red))
    rel_freqs = {bgs_list[i]: (bgs_fdist[bgs_list[i]]/total_words)*100  for i in range(len(bgs_list))}

    # Collapse bigrams into single strings
    bgs_final_list = list(rel_freqs.keys())
    bgs_final_list_v = list(rel_freqs.values())
    bgs_final_list = ["_".join(i) for i in bgs_final_list]

    # Translate into data frame
    bgs_frame = pd.DataFrame.from_dict({"bigrams": bgs_final_list, "rel_freq": bgs_final_list_v})
    
    return bgs_frame

def get_freqs(year_cons):
    # General specs
    punctuations = ['(',')',';',':','[',']',',', '.', '-']
    stop_words = stopwords.words('english')

    # Get file
    if year_cons<=2019:
        file_name = "AGS_" + str(year_cons) + ".pdf"
    else:
        file_name = "ASGS_" + str(year_cons) + ".pdf"
    file_path = os.path.join("ASGS", file_name)
    pdfReader = PyPDF2.PdfFileReader(file_path)
    
    count = 0
    text = ""
    n_pages = pdfReader.numPages
    while count < n_pages:
        page_obj = pdfReader.getPage(count)
        count += 1
        text += page_obj.extractText()
    tokens = word_tokenize(text)
    keywords = \
        [word for word in tokens if not word in stop_words and \
            not word in punctuations]
    freq = nltk.FreqDist(keywords)
    
    total_words = sum(freq.values())
    most_common_words = freq.most_common(total_words)
    words = \
        [most_common_words[i][0] for i in range(len(most_common_words))]
    freqs = \
        [(most_common_words[i][1]/total_words)*100 for i in range(
            len(most_common_words))]
    word_frame = pd.DataFrame.from_dict({"words": words, "freqs": freqs})
    word_frame["year"] = year_cons
    
    # Now the bigrams:
    bigram_frame = count_bigrams(text_used=text, 
                                 punctuations=punctuations, 
                                 stop_words=stop_words)
    bigram_frame["year"] = year_cons
    
    return {"word_frame": word_frame,
            "bigram_frame": bigram_frame}

def freq_analysis(years_cons):
    word_frames = []
    bigram_frames = []
    for y in years_cons:
        frames = get_freqs(y)
        word_frames.append(frames["word_frame"])
        bigram_frames.append(frames["bigram_frame"])
    word_frame_full = pd.concat(word_frames)
    bigram_frame_full = pd.concat(bigram_frames)
    return {"word_frame": word_frame_full, "bigram_frame": bigram_frame_full}

#%% main
if __name__ == "__main__":
    start = timeit.default_timer()
    
    y_considered = list(range(2011, 2022))
    result_frames = freq_analysis(y_considered)
    
    word_result_frame = result_frames["word_frame"]
    bigram_result_frame = result_frames["bigram_frame"]
    
    word_file_name = "asgs_freqs_" + str(y_considered[0]) + "-" + str(y_considered[-1]) + ".csv"
    csv_file_words = os.path.join("data", "tidy", word_file_name)
    word_result_frame.to_csv(csv_file_words)
    
    bigram_file_name = "asgs_freqs_" + str(y_considered[0]) + "-" + str(y_considered[-1]) + "_bgs.csv"
    csv_file_bgs = os.path.join("data", "tidy", bigram_file_name)
    bigram_result_frame.to_csv(csv_file_bgs)
    
    print("Saved ASGS word freqs to: ", csv_file_words)
    print("Saved ASGS bgs freqs to: ", csv_file_bgs)
    
    runtime = timeit.default_timer() - start    
    print("Finished. Total runtime: {} minutes".format(
        round(runtime/60, 2)))
    exit(0)

# %%
