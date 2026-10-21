// ============================================================
// js/auth.js — Funções compartilhadas de autenticação
// Descrição: Usadas por toda tela protegida, pra checar login
//            e mandar o token em toda requisição pra API.
// ============================================================

// ─── Bloqueia a página se não tiver um token guardado ───
function protegerPagina() {
  const token = localStorage.getItem('token')
  if (!token) {
    window.location.href = 'login.html'
  }
}

// ─── Faz um fetch normal, mas já anexando o token no cabeçalho ───
async function fetchAutenticado(url, opcoes = {}) {
  const token = localStorage.getItem('token')

  opcoes.headers = {
    ...opcoes.headers,           // mantém qualquer header que a chamada já tivesse (tipo Content-Type)
    'Authorization': `Bearer ${token}`
  }

  const resposta = await fetch(url, opcoes)

  if (resposta.status === 401) {
    // o token não é mais válido (expirou, ou foi removido) — manda de volta pro login
    localStorage.removeItem('token')
    window.location.href = 'login.html'
  }

  return resposta
}

// ─── Desloga: apaga o token e volta pra tela de login ───
function sair() {
  localStorage.removeItem('token')
  window.location.href = 'login.html'
}

function obterUsuarioLogado() {
    const token = localStorage.getItem('token')

    if (!token) {
        return null
    }

    try {
        const parte = token.split('.')[1]
        const base64 = parte.replace(/-/g, '+').replace(/_/g, '/')
        const preenchido = base64.padEnd(
            base64.length + (4 - base64.length % 4) % 4,
            '='
        )

        const bytes = atob(preenchido)
        const texto = decodeURIComponent(
            Array.from(bytes, caractere =>
                '%' + caractere.charCodeAt(0).toString(16).padStart(2, '0')
            ).join('')
        )

        return JSON.parse(texto)
    } catch (erro) {
        console.error('Não foi possível ler os dados do usuário:', erro)
        return null
    }
}

function mostrarUsuarioLogado() {
    const usuario = obterUsuarioLogado()

    if (!usuario) {
        return
    }

    const nome = document.getElementById('usuario-nome')
    const email = document.getElementById('usuario-email')
    const tipo = document.getElementById('usuario-tipo')
    const avatar = document.getElementById('usuario-avatar')

    if (nome) {
        nome.textContent = usuario.nome || usuario.sub || 'Usuário'
    }

    if (email) {
        email.textContent = usuario.sub || ''
    }

    if (tipo) {
        tipo.textContent = usuario.tipo === 'admin'
            ? 'Administrador'
            : 'Funcionário'
    }

    if (avatar) {
        avatar.textContent = (usuario.nome || usuario.sub || 'U')
            .charAt(0)
            .toUpperCase()
    }
}