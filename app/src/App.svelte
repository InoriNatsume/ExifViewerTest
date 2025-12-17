<script lang="ts">
  let selectedFile: File | null = null;
  let previewUrl: string | null = null;
  let errorMsg: string | null = null;

  function clearPreview() {
    if (previewUrl) URL.revokeObjectURL(previewUrl);
    previewUrl = null;
    selectedFile = null;
    errorMsg = null;
  }

  function onFileChange(e: Event) {
    const input = e.currentTarget as HTMLInputElement;
    const file = input.files?.[0] ?? null;

    // 매번 새로 선택하니까 이전 미리보기 URL은 해제
    if (previewUrl) URL.revokeObjectURL(previewUrl);
    previewUrl = null;
    selectedFile = null;
    errorMsg = null;

    if (!file) return;

    // 조건: 확장자/타입이 png인지 확인
    // (브라우저마다 type이 비어있을 수도 있어서 name도 같이 체크)
    const isPngByType = file.type === "image/png";
    const isPngByName = file.name.toLowerCase().endsWith(".png");

    if (!(isPngByType || isPngByName)) {
      errorMsg = "PNG 파일만 업로드할 수 있어.";
      input.value = ""; // 같은 파일 다시 선택 가능하게
      return;
    }

    selectedFile = file;
    previewUrl = URL.createObjectURL(file);
  }
</script>

<main class="min-h-screen bg-slate-950 text-slate-100 flex items-center justify-center p-6">
  <div class="w-full max-w-2xl rounded-2xl bg-slate-900/60 p-6 shadow">
    <h1 class="text-2xl font-bold">PNG 업로드 & 미리보기</h1>
    <p class="mt-2 text-slate-300">
      파일을 서버로 보내지 않고, 브라우저에서 바로 미리보기를 띄워.
    </p>

    <div class="mt-6 rounded-xl border border-slate-700 p-4">
      <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <label class="inline-flex items-center gap-3">
          <span class="text-sm text-slate-300">PNG 선택</span>
          <input
            type="file"
            accept="image/png,.png"
            class="text-sm text-slate-300 file:mr-4 file:rounded-lg file:border-0 file:bg-indigo-500 file:px-4 file:py-2 file:font-semibold file:text-white hover:file:bg-indigo-400"
            on:change={onFileChange}
          />
        </label>

        <button
          class="inline-flex items-center justify-center rounded-lg bg-slate-800 px-4 py-2 font-semibold hover:bg-slate-700"
          on:click={clearPreview}
          disabled={!selectedFile && !errorMsg}
        >
          초기화
        </button>
      </div>

      {#if errorMsg}
        <div class="mt-4 rounded-lg border border-rose-500/40 bg-rose-500/10 p-3 text-rose-200">
          {errorMsg}
        </div>
      {/if}

      <div class="mt-4 text-sm text-slate-400">
        선택된 파일:
        <span class="font-mono text-slate-200">{selectedFile ? selectedFile.name : "없음"}</span>
      </div>

      {#if previewUrl}
        <div class="mt-4">
          <img
            src={previewUrl}
            alt="업로드된 PNG 미리보기"
            class="max-h-[480px] w-full rounded-xl border border-slate-700 object-contain bg-slate-950"
          />
        </div>
      {/if}
    </div>
  </div>
</main>
